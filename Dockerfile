FROM wordpress:php8.1-apache

COPY docker/php/custom.ini $PHP_INI_DIR/conf.d/