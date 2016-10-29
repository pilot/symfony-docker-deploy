FROM phpmentors/symfony-app:php70

COPY ./ /var/app

#RUN apt-get update && \
#	apt-get install -y curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

VOLUME ["/var/app"]

WORKDIR /var/app

EXPOSE 80