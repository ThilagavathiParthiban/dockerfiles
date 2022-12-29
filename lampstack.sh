FROM ubuntu:20.04

# Install Apache, MySQL, and PHP
RUN apt-get update && apt-get install -y apache2 mysql-server php \
    && rm -rf /var/lib/apt/lists/*

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Copy PHP configuration file
COPY config/php.ini /etc/php/8.1/apache2/php.ini

# Copy Apache configuration file
COPY config/000-default.conf /etc/apache2/sites-available/000-default.conf

# Copy PHP scripts and website files
COPY src/ /var/www/html/

# Set the working directory to the website root
WORKDIR /var/www/html

# Expose the default Apache port
EXPOSE 80

# Start Apache in the foreground
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
