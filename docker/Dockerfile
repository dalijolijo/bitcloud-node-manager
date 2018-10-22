# 2018 The Bitcloud BTDX Core Developers (dalijolijo)
# Bitcloud Node Manager Docker Solution - Dockerfile

# Use an official Ubuntu runtime as a parent image
FROM ubuntu:16.04

LABEL maintainer="Jon D. (dArkjON), David B. (dalijolijo)"

# Make ports available to the world outside this container
# RPCPort = 8330
# BNM = 80
USER root

# Change sh to bash
SHELL ["/bin/bash", "-c"]

RUN echo '*** Bitcloud Node Manager Docker Solution ***'

#
# Installing required packages for bitcore-node-manager
#
RUN echo '*** Running updates and installing required packages for bitcore-node-manager***' && \
    apt-get update -y && \
    apt-get install -y 	apache2 \
			apt-utils \
			curl \
                        git \
			libapache2-mod-php \
			php \
 	       		php7.0-curl \
		       	screen \
			supervisor \
                        vim \
                        wget

#
# Install bitcore-node-manager
#
RUN git clone -b BTDX https://github.com/dalijolijo/bitcore-node-manager.git /var/www/html/btdx

#
# Copy Supervisor Configuration
#
COPY *.sv.conf /etc/supervisor/conf.d/

#
# Copy start script
#
RUN echo '*** Copy start script ***'
COPY start.sh /usr/local/bin/start.sh
RUN rm -f /var/log/access.log && mkfifo -m 0666 /var/log/access.log && \
    chmod 755 /usr/local/bin/*

ENV TERM linux
CMD ["/usr/local/bin/start.sh"]
