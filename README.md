# ego

A *non-production* provisioning tool for installing [MongoDB Ops Manager](https://www.mongodb.com/products/ops-manager) on all supported Linux and Windows operating systems, in AWS.

"ego" is a Bash script which can perform various useful tasks related to Ops Manager (and dependencies)
installs, upgrades, service management, etc.

It currently supports the following Operating Systems:
- Ubuntu 16.04, 18.04
- Debian 8, 9, 10
- Red Hat Enterprise 6.2, 7.x, 8.x
- SUSE 12, 15
- Amazon Linux 1, 2
- Windows 2012+ (w. Cygwin)

At a high-level, it works as follows:
1\. Provision a VM with AWS EC2 (or similar)
2\. run 'ego seed user@host' to install ego onto the target system
3\. from there onwards, you can run any number of tasks

**Note:** ego assumes the user has sufficient permissions to assume root on the target system,
as some actions require elevated privileges to complete.


# Quick start

1\. Install ego locally

```shell
curl -sL https://raw.githubusercontent.com/mongodb-labs/ego/master/install.sh | bash
# or
wget -qO- https://raw.githubusercontent.com/mongodb-labs/ego/master/install.sh | bash

# After installing, source the corresponding file for your shell, e.g.:
source ~/.bashrc
```

2\. Deploy ego in the target system

```shell
REMOTE_USER=...
REMOTE_HOST=...
ego seed "$REMOTE_USER@$REMOTE_HOST"
```

3\. Install Ops Manager

```shell
ego run "$REMOTE_USER@$REMOTE_HOST" ego ops_manager_install_version --version 4.2.15 --mongodb-version 4.2.8
```


### Debugging

If you want to enable explicit debugging of all ego actions and ssh traffic, 
you can: `export EGO_DEBUG=1` before running `ego`.


## Docker

You can also install and `ego` in [Docker](https://docs.docker.com/get-docker/).

```shell

# First, build the image
# NOTE: you can always rebuild the image (i.e., after making local changes), by running make again
make

# You can then run ego in docker by executing the following command
docker run -it $(make exec) [ARGS]
```

For example, you can provision Ops Manager on a remote host by running:
```shell
REMOTE_USER=...
REMOTE_HOST=...
docker run -it $(make exec) seed "$REMOTE_USER@$REMOTE_HOST"
docker run -it $(make exec) run "$REMOTE_USER@$REMOTE_HOST" ego ops_manager_install_version --version 4.2.15 --mongodb-version 4.2.8
```


# LICENSE

'ego' is free and the source is available. Ego is published
under the Server Side Public License (SSPL) v1. See individual files for
details.
