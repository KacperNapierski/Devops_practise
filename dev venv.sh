#!/bin/bash

#preparing dev-venv in fedora os

sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/$release/hashicorp.repo
sudo dnf install terraform
