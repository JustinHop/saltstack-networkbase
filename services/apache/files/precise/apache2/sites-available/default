<VirtualHost *:80>
        ServerAdmin webmaster@localhost
	# force https via redirect
	Redirect permanent / https://www.crowdrise.com/
        DocumentRoot /var/www/trunk/content
        <Directory />
                Options FollowSymLinks
                AllowOverride None
        </Directory>
        <Directory /var/www/trunk/content>
                Options Indexes FollowSymLinks MultiViews
                AllowOverride All
                Order allow,deny
                allow from all
        </Directory>

<Location /celebrity-fundraisers/special/firefoxchallengeevent>
#        AuthType Basic
#        AuthName "Restricted Area"
#        AuthUserFile "/var/www/vhosts/.htpasswd"
#        require valid-user
</Location>

        ErrorLog ${APACHE_LOG_DIR}/error.log

        # Possible values include: debug, info, notice, warn, error, crit,
        # alert, emerg.
        LogLevel warn

        CustomLog ${APACHE_LOG_DIR}/access.log combined


</VirtualHost>

