# salt-syslog
Deploy centralized syslog infrastructure via SaltStack

# vagrant

This repository is meant to be used as a local development environment. Easiest way to get started is to use virtualbox provider.

```
vagrant up
```

Vagrant environment will also deploy a dedicated saltmaster VM, in order to reflect realistic production setup. However, we do not pre-seed minion keys, allowing minion to generate new certificate requests upon each `vagrant up`. Therefore, developer must accept key manually within the saltmaster VM.

```
vagrant ssh saltmaster
sudo salt-key -L
sudo salt-key -A -y
salt '*' test.ping
```

Note that developer does not need superuser privileges to use salt execution modules as vagrant user. This is due to pre-configured ACL within salt-master config file. However, local system administration tasks (e.g. accepting certificate requests) still require elevation. You can orchestrate syslog deployment within saltmaster VM once the vagrant environment is operational.

```
sudo salt-run -l info state.orchestrate syslog saltenv=DEVEL
```
