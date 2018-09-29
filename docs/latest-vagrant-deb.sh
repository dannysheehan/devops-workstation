#!/bin/bash

LATEST_VAGRANT=$(curl -s https://releases.hashicorp.com/vagrant/index.json \
    | jq --raw-output \
        '.versions
        | with_entries(select(.key | test("-rc[0-9]+$") | not))
        | to_entries
        | max_by(.key)
        | .value.builds[]
        | select(.arch=="x86_64")
        | select(.os=="debian")
        | .url')
echo $LATEST_VAGRANT
