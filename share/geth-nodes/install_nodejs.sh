#!/bin/bash
# Download & install nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash

# Install nodejs
nvm install node
nvm use node

# Version check
node -v
npm -v
