syslog:
  pki:
    server: pki-ca
    policy: syslog
    dir: /srv/pki-syslog
    country: Estonia
    state: Harjumaa
    location: Tallinn
    org: Cats&dogs ltd

syslog_ng:
  server:
    version: '3.9.1-2'
    global:
      chain_hostnames: 'off'
      use_dns: 'no'
      use_fqdn: 'no'
      owner: 'syslog'
      group: 'syslog'
      perm: 0640
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
