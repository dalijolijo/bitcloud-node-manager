# Bitcloud Node Manager as Docker Solution
[![docker pulls](https://img.shields.io/docker/pulls/dalijolijo/bitcore-node-manager.svg?style=flat)](https://hub.docker.com/r/dalijolijo/bitcore-node-manager/)

## Deploy as a docker container

Support for the following distribution versions:
* CentOS 7.4 (x86_64-centos-7)
* Fedora 26 (x86_64-fedora-26)
* Fedora 27 (x86_64-fedora-27)
* Fedora 28 (x86_64-fedora-28)
* Debian 7 (x86_64-debian-wheezy)
* Debian 8 (x86_64-debian-jessie)
* Debian 9 (x86_64-debian-stretch)
* Debian 10 (x86_64-debian-buster)
* Ubuntu 14.04 LTS (x86_64-ubuntu-trusty)
* Ubuntu 16.04 LTS (x86_64-ubuntu-xenial)
* Ubuntu 17.10 (x86_64-ubuntu-artful)
* Ubuntu 18.04 LTS (x86_64-ubuntu-bionic)

### Download and execute the docker-ce installation script

Download and execute the automated docker-ce installation script - maintained by the Docker project.

```sh
sudo curl -sSL https://get.docker.com | sh
```

### Download and execute the script
Login as root, then do:

```sh
sudo bash -c "$(curl -fsSL https://github.com/dalijolijo/bitcore-node-manager/raw/master/docker/btdx-node-manager-docker.sh)"
```

## Bitcloud Node Manager 
The integrated Bitcloud RPC Server will download the blockchain bootstrap and will synced to the current block height.

Now view your Bitcloud Node Manager: http://localhost/btdx

**Hint:** If the Bitcloud Node Manager docker container is running on a server you must establish a tunnel for port 80 to use localhost.
![Putty Tunneling](/docker/putty-tunneling.png?raw=true "Putty Tunneling")
