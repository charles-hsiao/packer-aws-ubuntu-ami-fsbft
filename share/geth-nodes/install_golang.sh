#!/bin/bash
# For more info see https://golang.org/doc/install.html, the instructions
# there are all that is needed to install Go.
#
# DO NOT RUN with SUDO; Go should be installed under the user not root.
# Using sudo will cause problems.
#
# This script will install Go to /usr/local/go.  The default location for
# your Go workspace ($GOPATH) is $HOME/go.  A custom location can be
# specified using the -w or --workspace flag.
#
# Please see https://golang.org/doc/code.html for more information about
# code organization.
version="1.9.6"
goarch="amd64"
goos="linux"
workspace="$HOME/go"
listsupported=false

valid=(
        "darwin:386"
        "darwin:amd64"
        "freebsd:386"
        "freebsd:amd64"
        "linux:386"
        "linux:amd64"
        "linux:armv6l"
        "linux:ppc64le"
        "linux:390x"
        )

while [[ $# > 0 ]]
do
        case "$1" in
                -h|--help)
                        echo ""
                        echo "Usage: ./install_go [OPTIONS]"
                        echo ""
                        echo "  Do not use if you already have Go installed!"
                        echo ""
                        echo "  The default workspace location is $HOME/go"
                        echo "  The default os is $goos"
                        echo "  The default arch is $goarch"
                        echo "  The default version is $version"
                        echo ""
                        echo "  OPTIONS:"
                        echo "  -h, --help               print help message"
                        echo "  -w, --workspace          specify a custom workspace (\$GOPATH)"
                        echo "  -a, --arch, --goarch     specify the arch (\$GOARCH)"
                        echo "  -o, --os, --goos         specify the os (\$GOOS)"
                        echo "  -v, --version            specify the version"
                        echo "  -s, --supported          list the supported os:arch combinations"
                        echo ""

                        exit 0
                        ;;
                -w|--workspace)
                        workspace="$2"
                        shift
                        ;;
                -a|--goarch|--arch)
                        goarch="$2"
                        shift
                        ;;
                -o|--os|--goos)
                        goos="$2"
                        shift
                        ;;
                -v|--version)
                        version="$2"
                        shift
                        ;;
                -s|--supported)
                        listsupported = true
                        shift
                        ;;
        esac
shift
done


# see if it's a valid combination.
osarch=$goos$goarch

for v in "${valid[@]}"
do
        if [ "$v" = "$osarch" ] ; then
                isvalid=true
                break
        fi
done

# if it was an invalid combination them know
if ! $isvalid; then
        echo "invalid GOOS GOARCH combination: $goos $goarch"
fi

# if it was invalid or a listing was requested list supported combinations and exit
if ! $isvalid || $listsupported; then
        echo "supported GOOS GOARCH combinations:"
        for v in "${valid[@]}"
        do
                if [ "$v" = "linux:amd64" ]; then
                        echo "     $v (default)"
                else
                        echo "     $v"
                fi
        done
         exit 1
fi

# everything is ok
# first download
# download and extract Go to /usr/local/go/
wget_output=$(wget -O /tmp/go.$version.tar.gz https://storage.googleapis.com/golang/go$version.$goos-$goarch.tar.gz)
if [ $? -ne 0 ]; then
        echo "unable to install go $version"
        echo $wget_output
        exit 1
fi

tar_output=$(sudo tar xzf /tmp/go.$version.tar.gz -C /usr/local)
if [ $? -ne 0 ]; then
        echo "unable to install go $version"
        echo $tar_output
        exit 1
fi

# go was successfully downloaded and installed; set up the workspace
mkdir -p "$workspace"
echo export "GOPATH=$workspace" >> "$HOME/.bashrc"
echo export "PATH=$PATH:/usr/local/go/bin:$GOPATH/bin" >> "$HOME/.bashrc"
source "$HOME/.bashrc"

echo "complete: go $version installed"
echo "  GOPATH=$workspace"

