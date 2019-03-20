#!/bin/bash
# Change ssh key permission
chmod 400 ~/.ssh/ssh-fsbft.pem

# SSH add
eval `ssh-agent`
ssh-add ~/.ssh/ssh-fsbft.pem

