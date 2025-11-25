# Project README

<img src =https://github.com/Manomania/inception/blob/master/Diagram.svg>



## Useful Aliases

### File Synchronization
```bash
# Sync from sgoinfre to goinfre
vmtogoinfre = rsync -avh --progress sgoinfre to goinfre

# Sync from goinfre to sgoinfre  
vmtosgoinfre = rsync -avh --progress goinfre to sgoinfre
```

# Documentation Sources

## Mandatory Part

### Docker
- [Building Best Practices](https://docs.docker.com/build/building/best-practices/)
- [Compose File Legacy Versions - Healthcheck](https://docs.docker.com/reference/compose-file/legacy-versions/#healthcheck)

### NGINX
- [Official Documentation](https://nginx.org/en/docs/)
- [Commercial Documentation](https://docs.nginx.com/)
- [Beginner's Guide](https://nginx.org/en/docs/beginners_guide.html)
- [WordPress Performance Tips](https://blog.nginx.org/blog/9-tips-for-improving-wordpress-performance-with-nginx)

#### Security & Configuration
- [TLS 1.2 RFC](https://datatracker.ietf.org/doc/html/rfc5246)
- [HTTP/2 RFC](https://datatracker.ietf.org/doc/html/rfc7540)
- [Mozilla SSL Configuration Generator](https://ssl-config.mozilla.org/#server=nginx&version=1.27.3&config=modern&openssl=3.4.0&guideline=5.7)
- [OWASP TLS Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Transport_Layer_Security_Cheat_Sheet.html)

### SSL/TLS
- [TLS 1.3 RFC](https://datatracker.ietf.org/doc/html/rfc8446)
- [OpenSSL Master Documentation](https://docs.openssl.org/master/)
- [OpenSSL Cookbook](https://www.feistyduck.com/library/openssl-cookbook/)

### WordPress
- [Docker WordPress Sample](https://docs.docker.com/reference/samples/wordpress/)
- [WP-CLI Documentation](https://wp-cli.org/)
- [Docker Library WordPress](https://github.com/docker-library/wordpress)
- [WordPress Requirements](https://wordpress.org/about/requirements/)

### PHP-FPM
- [Installation Guide (French)](https://www.php.net/manual/fr/install.fpm.php)
- [Configuration Guide](https://www.php.net/manual/en/install.fpm.configuration.php)

### MariaDB
- [Optimization and Tuning](https://mariadb.com/docs/server/ha-and-performance/optimization-and-tuning)
- [MySQL Secure Installation](https://mariadb.com/docs/server/clients-and-utilities/legacy-clients-and-utilities/mysql_secure_installation)
- [Docker MariaDB Sample](https://docs.docker.com/reference/samples/mariadb/)
