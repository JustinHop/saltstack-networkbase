<VirtualHost *:443>
    ServerAdmin webmaster@localhost
    ServerName www.crowdrise.com

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


    ErrorLog ${APACHE_LOG_DIR}/error-ssl.log

    # Possible values include: debug, info, notice, warn, error, crit,
    # alert, emerg.
    LogLevel warn

    CustomLog ${APACHE_LOG_DIR}/access-ssl.log combined
    SSLEngine on
    SSLProtocol All -SSLv2 -SSLv3
    SSLCipherSuite HIGH:MEDIUM:!aNULL:!MD5:!SSLv3:!SSLv2:!TLSv1

    # SSLCertificateFile /etc/apache2/ssl/crowdrise.com.cert
    # SSLCertificateKeyFile /etc/apache2/ssl/crowdrise.com.key
    # SSLCertificateChainFile /etc/apache2/ssl/intermediate.crt

    # NEW 2016 wildcard.crowdrise.com SSL CERTIFICATE
    #
    SSLCertificateFile      /etc/pki/tls/certs/2016-wildcard.crowdrise.com.crt
    SSLCertificateKeyFile   /etc/pki/tls/private/2016-wildcard.crowdrise.com.key
    SSLCertificateChainFile /etc/pki/tls/certs/2016-wildcard.crowdrise.com.crt.ca

    BrowserMatch "MSIE [2-6]" \
        nokeepalive ssl-unclean-shutdown \
        downgrade-1.0 force-response-1.0
    # MSIE 7 and newer should be able to use keepalive
    BrowserMatch "MSIE [17-9]" ssl-unclean-shutdown

</VirtualHost>

