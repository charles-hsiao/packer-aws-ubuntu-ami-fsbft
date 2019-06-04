#!/bin/sh
# export go env
export GOPATH=/home/ubuntu/go
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/local/go/bin:/bin

# ---------------------------------------------------------------------------------------------------------------------
# Clone msigcode repo
# ---------------------------------------------------------------------------------------------------------------------
# Clone FSBFT to go path
git clone https://github.com/jianwei20/FastBFT_ethereum.git ~/FastBFT_ethereum

# Make geth
cd ~/FastBFT_ethereum
make geth

# ---------------------------------------------------------------------------------------------------------------------
# Clone msigcode repo
# ---------------------------------------------------------------------------------------------------------------------
# Change ssh key permission
chmod 400 ~/.ssh/msigcode

# Prevent Host key verification failed
ssh-keyscan -t rsa bitbucket.org >> ~/.ssh/known_hosts

# Clone msigcode to home directory
git clone git@bitbucket.org:walker088/msigcode.git ~/msigcode

# Checkout to msigcode branch
cd ~/msigcode
git checkout msigcode

# Make geth
make geth

# Clean-up ssh key
rm -f ~/.ssh/msigcode 

# ---------------------------------------------------------------------------------------------------------------------
# Install packages & Geth
# ---------------------------------------------------------------------------------------------------------------------
# Install build-essential
sudo apt-get install -y build-essential

# Source to prevent failure
export "GOPATH=$HOME/go"
export "PATH=$PATH:/usr/local/go/bin:$GOPATH/bin"

# Go get geth
#/usr/local/go/bin/go get github.com/ethereum/go-ethereum
go get -u github.com/ethereum/go-ethereum

# Compile geth
cd $GOPATH/src/github.com/ethereum/go-ethereum
make geth

