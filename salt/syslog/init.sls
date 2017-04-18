syslog.ca_setup:
  salt.state:
    - tgt: 'G@roles:syslog-ca and G@env:{{ saltenv }}'
    - tgt_type: compound
    - sls: syslog.pki.ca
    - saltenv: {{ saltenv }}
