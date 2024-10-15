#!/bin/bash
#
# prepara os volumes para os containers

mkdir -p /opt/postgres/data
mkdir -p /opt/helloworld
cp -Rpa django /opt/helloworld/app
docker build -t django:latest build/
ansible-playbook ../ansible/install_docker.yml
