#!/bin/bash

#preparing dev-venv in fedora os

sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
sudo dnf install terraform
python3 -m pip install --user ansible
python3 -m pip install --upgrade --user ansible
