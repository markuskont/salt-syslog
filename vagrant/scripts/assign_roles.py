#!/usr/bin/env python

import socket
import yaml
import subprocess

hostname = socket.gethostname()
grains = {
    'roles': []
}
command = ['service', 'salt-minion', 'restart']

if 'logserver' in hostname:
    grains['roles'].append('logserver')
    if 'rsyslog' in hostname:
        grains['roles'].append('rsyslog-server')
    elif 'syslog-ng' in hostname:
        grains['roles'].append('syslog-ng-server')
        grains['roles'].append('syslog-ca')
elif 'shipper' in hostname:
    grains['roles'].append('logs')

with open('/etc/salt/grains', 'w') as outfile:
    yaml.dump(grains, outfile, default_flow_style=False)

subprocess.call(command, shell=False)
