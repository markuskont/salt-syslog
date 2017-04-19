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
