FROM php:7-apache

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -y upgrade && apt-get -y install coreutils

COPY index.php /var/www/html/index.php

EXPOSE 80

CMD ["apache2-foreground"]

