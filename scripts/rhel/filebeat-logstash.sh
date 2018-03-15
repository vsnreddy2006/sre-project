#!/bin/bash

sudo apt update
sudo yum  -y install java-1.8.0-openjdk

# install logstash
sudo curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.2.2-x86_64.rpm
sudo rpm -vi filebeat-6.2.2-x86_64.rpm

sudo mv /tmp/logstash.yml /etc/logstash/logstash.yml
sudo mv /tmp/pipeline.conf /etc/logstash/conf.d/pipeline.conf
sudo systemctl daemon-reload
sudo systemctl start logstash.service
sudo systemctl enable logstash.service

# install filebeats
sudo curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.2.2-x86_64.rpm
sudo rpm -vi filebeat-6.2.2-x86_64.rpm
sudo mv /tmp/filebeat.yml /etc/filebeat/filebeat.yml

sudo systemctl enable filebeat.service
sudo systemctl start filebeat.service


