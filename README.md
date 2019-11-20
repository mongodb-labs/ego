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
curl -sL https://github.com/mongodb-labs/ego/raw/master/install.sh | bash
# or
wget -qO- https://github.com/mongodb-labs/ego/raw/master/install.sh | bash
```

2\. Deploy ego in the target system

```shell
ego seed user@REMOTE_HOST
```

3\. Install Ops Manager

```shell
ego run user@REMOTE_HOST ego ops_manager_install_version --version 4.2.3 --mongodb-version 4.2.1
```


# LICENSE

'ego' is free and the source is available. Ego is published
under the Server Side Public License (SSPL) v1. See individual files for
details.
