#!/usr/bin/env bash
#
# Installer script for ego
#
# Downloads and links ego locally
# Run with:
# curl -sL https://raw.githubusercontent.com/mongodb-labs/ego/master/install.sh | bash
#
declare -r SCRIPT="ego"
declare -r REPO="mongodb-labs/ego"

{ # ensure the entire install script is downloaded
EGO_HOME="${HOME}/.${SCRIPT}"

# Ensure ego's work dirs are created
if [ ! -d "$EGO_HOME" ]; then
    mkdir -p "${EGO_HOME}"
fi
if [ ! -d "$EGO_HOME/bin" ]; then
    mkdir -p "${EGO_HOME}/bin"
fi

has_command() {
    if ! command -v "$1" > /dev/null 2>&1
        then return 1;
        else return 0;
    fi
}

download() {
    echo "Downloading $*..."
    if has_command curl; then
        HTTPS_PROXY=${HTTPS_PROXY:-$https_proxy}
        "$(command -v curl)" --silent --location --remote-name "$@"
    elif has_command wget; then
        https_proxy=${https_proxy:-$HTTPS_PROXY}
        "$(command -v wget)" -q "$@"
    else
        echo "Could not find curl or wget on target host; cannot proceed!"
        echo
        exit 1
    fi
}

link() {
    # Add ego to the user's PATH
    if [ ! -f "$1" ]; then
        # Do nothing if the file does not exist
        return
    fi
    if grep -qs "# EGO" "$1"; then
        # Already linked, do nothing
        return
    fi

    # Add ego to the user's shell PATH
    (
    echo ""
    echo "# EGO"
    echo "export PATH=\"$EGO_HOME/bin:\$PATH\""
    ) >> "$1"

    echo "Added ${SCRIPT} to PATH via $1"
}

link_fish() {
    if [ ! -f "$1" ]; then
        # Do nothing if the file does not exist
        return
    fi
    if grep -qs "# EGO" "$1"; then
        # Already linked, do nothing
        return
    fi

    # Add ego to fish's path
    (
    echo ""
    echo "# EGO"
    echo "fish_add_path $EGO_HOME/bin"
    ) >> "$1"

    echo "Added ${SCRIPT} to PATH via $1"
}

echo "Installing ${SCRIPT}..."
echo
pushd "${EGO_HOME}/bin" > /dev/null || ( echo "Could not change dir to ${EGO_HOME}; exiting"; exit 1 )
download "https://raw.githubusercontent.com/${REPO}/master/bin/${SCRIPT}"
chmod u+x "${SCRIPT}"
popd > /dev/null || exit 2

echo "Linking ego in the system path..."
link "${HOME}/.zshrc"
link "${HOME}/.bashrc"
link "${HOME}/.profile"
link "${HOME}/.bash_profile"
link_fish "${HOME}/.config/fish/config.fish"

echo "Installation complete!"
echo
echo "Please report any issues at: https://github.com/${REPO}/issues"
echo

} # ensure the entire install script is downloaded
