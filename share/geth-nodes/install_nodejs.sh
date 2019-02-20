#!/usr/bin/env bash
# Download & install nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash

# Source NVM
source $HOME/.nvm/nvm.sh

# Install nodejs
nvm install node
nvm use node

# Version check
node -v
npm -v

# Install ethereumjs-wallet via npm
npm install ethereumjs-wallet
