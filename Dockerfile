FROM debian:buster

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install nginx	\
                        openssl	\
                        wget	\
                        mariadb-server	\
                        vim     
RUN apt-get -y install php7.3-fpm	\
                        php7.3-mysql	\
                        php7.3-mbstring
COPY ./srcs/start.sh ./
COPY ./srcs/autoindex_on.sh ./tmp/autoindex_on.sh
COPY ./srcs/autoindex_off.sh ./tmp/autoindex_off.sh
COPY ./srcs/default ./tmp/default
COPY ./srcs/config.inc.php ./tmp/config.inc.php
COPY ./srcs/wp-config.php ./tmp/wp-config.php

EXPOSE 8080 443

CMD bash start.sh