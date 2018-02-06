# Build a local infrastructure

Your task is to create a local fully automated infrastructure using the tools of your choice, deployed where you choose, (vagrant, aws, do, etc)

This should identify your abilities to build an infrastructure from scratch using automated tools, and your abilities as a systems administrator.

### Requirements:
Your task is to create a highly available ELK (Elasticsearch, Logstash, kibana) cluster.

Filebeat should run on each box, forwarding traffic to logstash, which in turn is ingested into elasticsearch, and visible from kibana. 

The entrypoint should be the kibana ui, listening on 443. A self-signed certificate should be used on the listener.

Be security conscious. 

### The Solution:
A well thought out project, with emphasis on readability and maintainability. We expect that we should be able to run your setup locally.

### Steps:
1) Fork this repository, and solve on your fork
2) When completed, send an email to your contact with a link to your completed example



