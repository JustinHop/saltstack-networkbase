#####
# Crowdrise varnish config
#
# Notes:  Caching Rules are based on:
# 1.  Logged in users. - NOT CACHED
# 2.  What can be cached for very long durations (things that dont change much per day) - 1 hour cache
# 3.  What the user must see extremely quickly -  Leaving out Events and Fundraiser pages for now.
####

##
# acl purge
# Please change this to contain our cluster.
##
acl purge {
  "localhost";
}

##
# Probe for healthchecks
##
#probe healthcheck {

#  .url = "/webnode-status";
#  .timeout = 0.3s;
#  .interval = 5s;
#  .window = 8;
#  .threshold = 3;

#}

##
# Web nodes here. (example shown below.  All must have a health check 
# we can ping)
##
backend webnode1 {
	.host = "http.front.load1.base.com";
	.port = "80";
#	.probe = healthcheck;
}

#backend webnode2 {
#	.host = "192.168.33.10";
#	.port = "8080";
#       .probe = healthcheck;
#}


#Add the web nodes to the cluster now.
director webnode_cluster round-robin {

	{ .backend = webnode1; }
	#.backend = webnode2;
}


##
# Sub Receive
# What to do when we receive a request from 
# a user making a request. 
##
sub vcl_recv {

  #Serve up stale content for up 2 hours if one of our machines goes down.
  set req.grace = 2h;
  
  #Set the user agent (normalized)
  call normalize_user_agent;

  #Set the Varnish Request Id. Each call has a unique id just in case we ever need to track on 
  #the backend
  set req.http.X-Varnish-XID = req.xid;

  #Set the authetication headers - For push ONLY!!!
  set req.http.Authorization = "Basic Y3Jvd2RyaXNlOmphbGVucjU=";

  #Gives us the ability to bust the cache for specific 
  #iems using a PURGE request.  Machine must be within the 
  #network.
  if(req.request == "PURGE"){
    if(!client.ip ~ purge){
      error 405 "Not allowed.";
    }
    
    return (lookup);
  }

  if (req.restarts == 0) {
    if (req.http.x-forwarded-for) {
	    set req.http.X-Forwarded-For =
 		req.http.X-Forwarded-For + ", " + client.ip;

    }
  }

  if (req.request != "GET" &&
       req.request != "HEAD" &&
       req.request != "PUT" &&
       req.request != "POST" &&
       req.request != "TRACE" &&
       req.request != "OPTIONS" &&
       req.request != "DELETE") {
         /* Non-RFC2616 or CONNECT which is weird. */
         return (pipe);
  }
  
  if (req.request != "GET" && req.request != "HEAD") {
         /* We only deal with GET and HEAD by default */
         return (pass);
  }

  #Pass the logged in users. 
  #Check if the user is going to logged-in specific pages. If so, DONT cache those pages.
  #Pass the request around varnish.
  if(req.url ~ "/account/?.*" || req.http.cookie ~ "base"){
    return (pass);
  }

  #Check if the user is requesting the pages we DO want to cache. 
  #Note that we will cache EVERYTHING.  Static content (Images, JS, CSS, etc) as well as HTML.
  if(req.url == "/" || 
     req.url ~ "/about/?.*" ||
     req.url ~ "/community/?.*" || 
     req.url ~ "/base/?.*" ||
     req.url ~ "/fundraise-and-volunteer/signup-select$" ||
     req.url ~ "/search/projects$" ||
     req.url ~ "/search/charities$" || 
     req.url ~ "/search/events$" || 
     req.url ~ "/online-fundraising$" ||
     req.url ~ "/give/promotions$" || 
     req.url ~ "/charities/?.*" ||
     req.url ~ "/fundraising-events$" ||
     req.url ~ "/event/signup$" ||
     req.url ~ "(?i)\.(png|gif|jpg|jpeg|css|js)$"){
    
     unset req.http.Cookie;
     
     return (lookup);
  }

  #Send the request to the backend.
  return (pass);

}
 
##
# sub vcl_hash
## 
sub vcl_hash {
     hash_data(req.url);
     if (req.http.host) {
         hash_data(req.http.host);
     } else {
         hash_data(server.ip);
   }
     return (hash);
}


##
# Sub vcl_fetch
## 
sub vcl_fetch {

  #Serve backend content for upto 2 hours if the machine does down.
  #Nice feature.  Turn off the web nodes and watch the cached cotent continue to be served up.
  set beresp.grace = 2h;

  #Let varnish know what cluster to use during fetching.
  set req.backend = webnode_cluster;

  #Set the X-UA and Vary back to the original request before 
  #sending it ack to the user since we no longer need to place it into buckets.
  set beresp.http.X-UA = req.http.X-UA;
  set beresp.http.Vary = "Accept-Encoding,X-UA";

  #Remove all cookies returned by the web nodes.	
  if(req.url ~ "/account/?.*" || req.http.cookie ~ "base"){} 
  else {
 
    #Let varnish know to cache everything for X seconds.
    if(req.url == "/" ||
     req.url ~ "/about/?.*" ||
     req.url ~ "/community/?.*" ||
     req.url ~ "/base/?.*" ||
     req.url ~ "/fundraise-and-volunteer/signup-select$" ||
     req.url ~ "/search/projects$" ||
     req.url ~ "/search/charities$" ||
     req.url ~ "/search/events$" ||
     req.url ~ "/online-fundraising$" ||
     req.url ~ "/give/promotions$" ||
     req.url ~ "/charities/?.*" ||
     req.url ~ "/fundraising-events$" ||
     req.url ~ "/event/signup$" ||
     req.url ~ "(?i)\.(png|gif|jpg|jpeg|css|js)$"){

      #Remove the cookies for these items only if the user is not logged in
      unset beresp.http.set-cookie;

      set beresp.ttl = 3600s; #1 hour

    }
  }

}
 

##
# Sub vcl_deliver
# Add in any special headers RIGHT before we hand it 
# off to the user making the request. 
##
sub vcl_deliver {

  #For debugging we might need this.  Maybe obfuscate it at some point.
  set resp.http.X-Served-By = server.hostname;
	
  #Determine if its a hit or miss
  if(obj.hits > 0){
    set resp.http.X-Cache = "HIT";
    set resp.http.X-Cache-HIts = obj.hits;
  }else{
    set resp.http.X-Cache = "MISS";
  }

  return (deliver);

}
 

##
# Sub vcl_error
##
sub vcl_error {
     set obj.http.Content-Type = "text/html; charset=utf-8";
     set obj.http.Retry-After = "5";
     synthetic {"
 <?xml version="1.0" encoding="utf-8"?>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
 <html>
   <head>
     <title>"} + obj.status + " " + obj.response + {"</title>
   </head>
   <body>
     <h1>Error "} + obj.status + " " + obj.response + {"</h1>
     <p>"} + obj.response + {"</p>
     <h3>Guru Meditation:</h3>
     <p>XID: "} + req.xid + {"</p>
     <hr>
     <p>Varnish cache server</p>
   </body>
 </html>
 "};
     return (deliver);
}

##
# sub nomalize the user agents
# since each unique user agents will create a new cache bucket we
# should normalize these buckets to catch more user agents within each bucket
##
sub normalize_user_agent {
    
  if (req.http.user-agent ~ "MSIE") {
        set req.http.X-UA = "msie";
    } else if (req.http.user-agent ~ "Firefox") {
        set req.http.X-UA = "firefox";
    } else if (req.http.user-agent ~ "Safari") {
        set req.http.X-UA = "safari";
    } else if (req.http.user-agent ~ "Opera Mini/") {
        set req.http.X-UA = "opera-mini";
    } else if (req.http.user-agent ~ "Opera Mobi/") {
        set req.http.X-UA = "opera-mobile";
    } else if (req.http.user-agent ~ "Opera") {
        set req.http.X-UA = "opera";
    } else if(req.http.user-agent ~ "Mobile"){
      set req.http.X-UA = "mobile";
    } else if(req.http.user-agent ~ "Android"){
      set req.http.X-UA = "android";
    } else if(req.http.user-agent ~ "Opera Mini/"){
      set req.http.X-UA = "mobile";
    } else if(req.http.user-agent ~ "Opera Mobi/"){
      set req.http.X-UA = "android";
    } else if(req.http.user-agent ~ "iPad"){
      set req.http.X-UA = "iPad";
    } else if(req.http.user-agent ~ "iPhone"){
      set req.http.X-UA = "iPhone";
    } else {
        set req.http.X-UA = req.http.user-agent;
    }
    
}


##
# Sub vcl_hit 
# Extra stuff to do if there is a cache it.
##
sub vcl_hit {

  if(req.request == "PURGE"){
    purge;
    error 200 "Purched";
  }

}


##
# Sub vlc_miss 
# Purge response on a cache miss (not in cache)
##
sub vcl_miss {

  if(req.request == "PURGE"){
    purge;
    error 200 "Not in cache";
  }

}
