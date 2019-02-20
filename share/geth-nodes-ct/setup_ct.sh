#!/bin/bash
# Change ssh key permission
chmod 400 ~/.ssh/ssh-fsbft.pem

# SSH add
ssh-add ~/.ssh/ssh-fsbft.pem

