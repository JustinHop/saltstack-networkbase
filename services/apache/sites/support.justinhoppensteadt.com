
<VirtualHost *:80>
    ServerAdmin webmaster@localhost

    DocumentRoot /var/www
    <Directory />
        Options FollowSymLinks
        AllowOverride None
    </Directory>
    <Directory /var/www/>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride None
        Order allow,deny
        allow from all
    </Directory>

    ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/
    <Directory "/usr/lib/cgi-bin">
        AllowOverride None
        Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch
        Order allow,deny
        Allow from all
    </Directory>


    # apache configuration for nagios 3.x
    # note to users of nagios 1.x and 2.x:
    #   throughout this file are commented out sections which preserve
    #   backwards compatibility with bookmarks/config for older nagios versios.
    #   simply look for lines following "nagios 1.x:" and "nagios 2.x" comments.

    ScriptAlias /cgi-bin/nagios3 /usr/lib/cgi-bin/nagios3
    ScriptAlias /nagios3/cgi-bin /usr/lib/cgi-bin/nagios3
    # nagios 1.x:
    #ScriptAlias /cgi-bin/nagios /usr/lib/cgi-bin/nagios3
    #ScriptAlias /nagios/cgi-bin /usr/lib/cgi-bin/nagios3
    # nagios 2.x: 
    #ScriptAlias /cgi-bin/nagios2 /usr/lib/cgi-bin/nagios3
    #ScriptAlias /nagios2/cgi-bin /usr/lib/cgi-bin/nagios3

    # Where the stylesheets (config files) reside
    Alias /nagios3/stylesheets /etc/nagios3/stylesheets
    # nagios 1.x:
    #Alias /nagios/stylesheets /etc/nagios3/stylesheets
    # nagios 2.x:
    #Alias /nagios2/stylesheets /etc/nagios3/stylesheets

    # Where the HTML pages live
    Alias /nagios3 /usr/share/nagios3/htdocs
    # nagios 2.x: 
    #Alias /nagios2 /usr/share/nagios3/htdocs
    # nagios 1.x:
    #Alias /nagios /usr/share/nagios3/htdocs

    <DirectoryMatch (/usr/share/nagios3/htdocs|/usr/lib/cgi-bin/nagios3|/etc/nagios3/stylesheets)>
        Options FollowSymLinks

        DirectoryIndex index.php index.html

        AllowOverride AuthConfig
        Order Allow,Deny
        Allow From All

        AuthName "Nagios Access"
        AuthType Basic
        AuthUserFile /etc/nagios3/htpasswd.users
        # nagios 1.x:
        #AuthUserFile /etc/nagios/htpasswd.users
        require valid-user
    </DirectoryMatch>

    <Directory /usr/share/nagios3/htdocs>
        Options +ExecCGI    
    </Directory>

    # Enable this ScriptAlias if you want to enable the grouplist patch.
    # See http://apan.sourceforge.net/download.html for more info
    # It allows you to see a clickable list of all hostgroups in the
    # left pane of the Nagios web interface
    # XXX This is not tested for nagios 2.x use at your own peril
    #ScriptAlias /nagios3/side.html /usr/lib/cgi-bin/nagios3/grouplist.cgi
    # nagios 1.x:
    #ScriptAlias /nagios/side.html /usr/lib/cgi-bin/nagios3/grouplist.cgi


    ErrorLog ${APACHE_LOG_DIR}/error.log

    # Possible values include: debug, info, notice, warn, error, crit,
    # alert, emerg.
    LogLevel warn

    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
