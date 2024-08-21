FROM php:8.2-fpm-alpine

RUN apk update && apk add --no-cache \
    python3 \
    py-pip \
    nginx \
    supervisor \
    libpcap

RUN pip install scapy --break-system-packages

RUN sed -i 's/;listen.owner = www-data/listen.owner = nginx/' /usr/local/etc/php-fpm.d/www.conf && \
    sed -i 's/;listen.group = www-data/listen.group = nginx/' /usr/local/etc/php-fpm.d/www.conf && \
    sed -i 's/listen = 9000/listen = \/var\/run\/php-fpm.sock/' /usr/local/etc/php-fpm.d/zz-docker.conf && \
    sed -i 's/listen = 127.0.0.1:9000/listen = \/var\/run\/php-fpm.sock/' /usr/local/etc/php-fpm.d/www.conf

COPY pppwn /pppwn
COPY nginx/default.conf /etc/nginx/http.d/default.conf
COPY html /var/www/html
COPY supervisord.conf /etc/supervisord.conf

EXPOSE 8066

WORKDIR "/pppwn"
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
