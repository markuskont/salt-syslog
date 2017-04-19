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
    - server: 192.168.56.141
      port: 6514
      rsyslog_format: 'RSYSLOG_ForwardFormat'
    - server: 192.168.56.142
      port: 6514
      rsyslog_format: 'RSYSLOG_ForwardFormat'

syslog_ng:
  server:
    version: '3.9.1-2'
    global:
      chain_hostnames: 'off'
      use_dns: 'no'
      use_fqdn: 'no'
      owner: 'syslog'
      group: 'syslog'
      perm: 640
      stats_freq: 0
      bad_hostname: '^gconfd$'
      create_dirs: 'yes'
      threaded: 'yes'
      flush_lines: 100
      log_fifo_size: 25000
      keep_timestamp: 'no'
      ts_format: 'rfc3339'
      time_reopen: 1
    src:
      maxconn: 250
      logfetch: 100
      logiwsize: 100
    logfiles:
      d_local_file: '/var/log/server/$FACILITY.$LEVEL.log'
      d_local_debug: '/var/log/debug.log'
      d_local_syslog_err: '/var/log/syslog_err.log'
      d_local_daemon: '/var/log/server/$FACILITY/$PROGRAM.$LEVEL.log'
      d_local_byhost: '/var/log/hosts/$HOST.log'
      d_local_custom: '/var/log/custom/$PROGRAM.log'
      d_local_ovpn: '/var/log/openvpn/$HOST-$PROGRAM.log'
      d_local_criticality: '/var/log/criticality/$LEVEL.log'
      d_local_mail: '/var/log/mail/$HOST.log'

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
