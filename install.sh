#!/usr/bin/env bash
#
# Installer script for ego
#
# Downloads and links ego locally
# Run with:
# curl -sL https://github.com/mongodb-labs/ego/raw/master/install.sh | bash
#

{ # download entire script
EGO_HOME="${HOME}/.ego"

# Ensure ego's work dirs are created
if [ ! -d "$EGO_HOME" ]; then
    mkdir "${EGO_HOME}"
fi
if [ ! -d "$EGO_HOME/bin" ]; then
    mkdir "${EGO_HOME}/bin"
fi

has_command() {
    if ! command -v "$1" > /dev/null 2>&1
    then echo 1;
    else echo 0;
    fi
}

download() {
    if command -v curl; then
        HTTPS_PROXY=${HTTPS_PROXY:-$https_proxy}
        "$(command -v curl)" --silent --location --remote-name "$@"
    elif command -v wget; then
        https_proxy=${https_proxy:-$HTTPS_PROXY}
        "$(command -v wget)" -q "$@"
    else
        echo "Could not find curl or wget on target host; cannot proceed!"
        echo
        exit 1
    fi
}

echo "Installing ego..."
echo
pushd "${EGO_HOME}/bin" > /dev/null || ( echo "Could not change dir to ${EGO_HOME}; exiting"; exit 1 )
download "https://github.com/mongodb-labs/ego/blob/master/bin/ego"
popd > /dev/null || exit 2

echo "Linking ego in the system path"
echo
"${EGO_HOME}/bin/ego" link

echo ""
echo "Installation complete!"
echo "Please report any issues at: https://github.com/mongodb-labs/ego/issues"
echo

} # download entire script
