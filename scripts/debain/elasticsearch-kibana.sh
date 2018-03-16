#!/bin/bash

sudo apt update
sudo apt install openjdk-8-jdk -y

# install elasticsearch
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.2.2.deb
sudo dpkg -i elasticsearch-6.2.2.deb

sudo mv /tmp/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
sudo systemctl daemon-reload
sudo systemctl enable elasticsearch.service
sudo systemctl start elasticsearch.service

# install kibana
wget https://artifacts.elastic.co/downloads/kibana/kibana-6.2.2-amd64.deb
sudo dpkg -i kibana6.2.2-amd64.deb
sudo sysctl -w vm.max_map_count=262144

sudo mv /tmp/kibana.yml /etc/kibana/kibana.yml
sudo mkdir -p /etc/ssl/private/
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj "/C=US/ST=IDAHO/L=BOISE/O=default/OU=default/CN=hostname"  -keyout /etc/ssl/private/kibana-selfsigned.key -out /etc/ssl/certs/kibana-selfsigned.crt
sudo systemctl daemon-reload
sudo systemctl enable kibana.service
sudo systemctl start kibana.service


