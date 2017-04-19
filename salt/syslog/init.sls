syslog.ca.setup:
  salt.state:
    - tgt: 'G@roles:syslog-ca and G@env:{{ saltenv }}'
    - tgt_type: compound
    - sls: syslog.pki.ca
    - saltenv: {{ saltenv }}

syslog.logserver.setup:
  salt.state:
    - tgt: 'G@roles:logserver and G@env:{{ saltenv }}'
    - tgt_type: compound
    - sls: syslog.server
    - saltenv: {{ saltenv }}
    - require:
      - salt: syslog.ca.setup

#syslog.ensure-up-to-date-jinja2:
#  salt.state:
#    - tgt: 'G@roles:logs and G@oscodename:precise and G@env:{{ saltenv }}'
#    - tgt_type: compound
#    - sls: syslog.common.jinja2
#    - saltenv: {{ saltenv }}

syslog.client.setup:
  salt.state:
    - tgt: 'G@roles:logs and G@env:{{ saltenv }}'
    - tgt_type: compound
    - sls: syslog.client
    - saltenv: {{ saltenv }}
    - require:
      - salt: syslog.ca.setup
      - salt: syslog.logserver.setup
