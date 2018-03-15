#!/bin/bash

sudo apt update
sudo apt install openjdk-8-jdk -y

# install logstash
wget https://artifacts.elastic.co/downloads/logstash/logstash-6.2.2.deb
sudo dpkg -i logstash-6.2.2.deb

sudo mv /tmp/logstash.yml /etc/logstash/logstash.yml
sudo mv /tmp/pipeline.conf /etc/logstash/conf.d/pipeline.conf
sudo systemctl daemon-reload
sudo systemctl start logstash.service
sudo systemctl enable logstash.service

# install filebeats
sudo /usr/share/logstash/bin/logstash-plugin install logstash-input-beats

curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.2.2-amd64.deb
sudo dpkg -i filebeat-6.2.2-amd64.deb
sudo mv /tmp/filebeat.yml /etc/filebeat/filebeat.yml

sudo systemctl enable filebeat.service
sudo systemctl start filebeat.service

