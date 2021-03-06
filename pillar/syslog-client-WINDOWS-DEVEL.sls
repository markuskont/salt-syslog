syslog:
  pki:
    server: pki-ca
    policy: syslog
    dir: /srv/pki-syslog
    country: Estonia
    state: Harjumaa
    location: Tallinn
    org: Cats&dogs ltd
  params:
    PermPeer: '*'
  servers:
    - server: logserver-syslog-ng
      port: 514
      rsyslog_format: 'RSYSLOG_ForwardFormat'
    - server: logserver-rsyslog
      port: 6514
      rsyslog_format: 'RSYSLOG_ForwardFormat'
