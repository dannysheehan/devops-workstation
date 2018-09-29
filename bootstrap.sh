#!/bin/bash

#
# We need ansible. The latest releases are kept more up-to-date than
# those released as part of the Unbutu distribution.
#
sudo apt-get update
sudo apt-get install software-properties-common
sudo apt-get install git
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible
