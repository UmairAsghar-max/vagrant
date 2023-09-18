#!/bin/bash

# Start and Provision VMs && SSH to the vagrant machine as a DEAMON
# ===================================================
vagrant up && vagrant ssh kube-lab -c "ttyd -W bash" --no-tty
