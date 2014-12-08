
find /var/log/syslog/2008 -type f -mtime +1  -name "*.log" -exec bzip2 '{}' \;
