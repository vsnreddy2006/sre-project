#!/bin/bash

sudo yum update
sudo yum  -y install java-1.8.0-openjdk

# install elasticsearch
sudo curl -L -O https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.2.2.rpm
sudo rpm --install elasticsearch-6.2.2.rpm

sudo mv /tmp/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
sudo systemctl daemon-reload
sudo systemctl enable elasticsearch.service
sudo systemctl start elasticsearch.service



