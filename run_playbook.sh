#!/usr/bin/env bash
# example usage: ./run_playbook.sh --private-key=~/.ssh/<a private key with access>
ansible-playbook tasks.yaml -i inventory.yaml $@