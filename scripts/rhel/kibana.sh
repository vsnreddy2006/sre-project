#!/bin/bash

sudo yum update
sudo yum  -y install java-1.8.0-openjdk

# install kibana
sudo curl -L -O https://artifacts.elastic.co/downloads/kibana/kibana-6.2.2-x86_64.rpm
sudo rpm -ivh kibana-6.2.2-x86_64.rpm

sudo mv /tmp/kibana.yml /etc/kibana/kibana.yml
sudo mkdir -p /etc/ssl/private/
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048  -subj "/C=US/ST=SomeState/L=SanLocality/O=SomeOrg/OU=SomeUnit/CN=common.name"  -keyout /etc/ssl/private/kibana-selfsigned.key -out /etc/ssl/certs/kibana-selfsigned.crt
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048  -subj "/C=US/ST=SomeState/L=SanLocality/O=SomeOrg/OU=SomeUnit/CN=common.name"  -keyout /etc/ssl/private/kibana-selfsigned.key -out /etc/ssl/certs/kibana-selfsigned.crt
sudo systemctl daemon-reload
sudo systemctl enable kibana.service
sudo systemctl start kibana.service

