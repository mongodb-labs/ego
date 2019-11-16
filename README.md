# ego

A *non-production* provisioning tool for installing [MongoDB Ops Manager](https://www.mongodb.com/products/ops-manager) on all supported Linux and Windows operating systems, in AWS.

# Quick start

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
1\. use another system (MCI, EVG, EC2, Azure, etc.) to spin up a VM
2\. run 'ego seed user@host' to upload ego onto the target system
3\. from there onwards, you can run any number of tasks (see below)


# LICENSE

'ego' is free and the source is available. Ego is published
under the Server Side Public License (SSPL) v1. See individual files for
details.
