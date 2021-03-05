FROM		debian:buster
LABEL		maintainer="yjung.student.42seoul.kr"
# init arg
ARG 		WP_NAME=wordpress
ARG 		WP_USER=yjung
ARG 		WP_PWD=1234
# init
 RUN			apt update -y ; apt-get upgrade -y
#install dependency
RUN			apt instatll nginx php-fpm mariadb-server php-mysql php-mbstring vim curl -y 
#setup Wordpress
RUN 		openssl genrsa -out ft_server.localhost.key 4096; \
			openssl req -x509 -nodes -days 365 \
			-key ft_server.localhost.key \
			-out ft_server.localhost.crt \
			-subj "/C=KR/ST=SEOUL/L=Gaepo-dong/O=42Seoul/OU=yjung/CN=localhost"; \
			chmod 644 ft_server.localhost.*; \
			mv ft_server.localhost.crt /etc/ssl/certs/;	\
			mv ft_server.localhost.key /etc/ssl/private/; \
			cp /default /etc/nginx/sites-available/default
#setup phpmyadmin
RUN 		curl -O https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz
RUN 		tar -xzf phpMyAdmin-5.0.4-all-languages.tar.gz -C /var/www/html/; \
			mv /var/www/html/phpMyAdmin-5.0.4-all-languages /var/www/html/phpmyadmin; \
			mv /var/www/html/phpmyadmin/config.sample.inc.php /var/www/html/phpmyadmin/config.inc.php; \
# setup Wordpress
RUN 		tar -xzf wordpress.tar.gz -C /var/www/html/; \
			mv /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php; \
			sed -i "s/database_name_here/${WP_NAME}/g" /var/www/html/wordpress/wp-config.php; \
			sed -i "s/username_here/${WP_USER}/g" /var/www/html/wordpress/wp-config.php; \
			sed -i "s/password_here/${WP_PWD}/g" /var/www/html/wordpress/wp-config.php
COPY		./srcs/run.sh ./

RUN 		chown -R www-data:www-data /var/www/html/

EXPOSE		80 443

ENTRYPOINT ["/bin/bash", "-C", "/run.sh"]
