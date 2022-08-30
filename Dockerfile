FROM wordpress:php8.1-apache

# Add crontab file in the cron directory
ADD docker/cron/crontab /etc/cron.d/wp-cron

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/wp-cron

# Create the log file to be able to run tail
RUN touch /var/log/cron.log
# update and upgrade
RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y --no-install-recommends \
    supervisor \
    cron ;

RUN mkdir -p /var/log/supervisor

RUN pecl install \
    apcu \
    redis ;

RUN rm -rf /tmp/pear;


RUN docker-php-ext-enable \
    apcu \
    redis ;

COPY docker/supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY docker/php/custom.ini $PHP_INI_DIR/conf.d/



CMD ["/usr/bin/supervisord"]