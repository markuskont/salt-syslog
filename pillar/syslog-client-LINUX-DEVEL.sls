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
      port: 6514
      rsyslog_format: 'RSYSLOG_ForwardFormat'
    - server: logserver-rsyslog
      port: 6514
      rsyslog_format: 'RSYSLOG_ForwardFormat'

rsyslog:
  global:
    FileOwner: 'syslog'
    FileGroup: 'syslog'
    FileCreateMode: '0640'
    DirOwner: 'syslog'
    DirGroup: 'syslog'
    DirCreateMode: '0755'
    PrivDropToUser: 'root'
    PrivDropToGroup: 'root'
    WorkDirectory: '/var/spool/rsyslog'
