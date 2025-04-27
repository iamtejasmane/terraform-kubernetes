#!/bin/bash

sudo apt update -y && sudo apt install -y wget unzip

wget https://releases.hashicorp.com/terraform/1.1.5/terraform_1.1.5_linux_amd64.zip

unzip terraform_1.1.5_linux_amd64.zip

sudo mv terraform /usr/local/bin/

rm terraform_1.1.5_linux_amd64.zip

terraform version

