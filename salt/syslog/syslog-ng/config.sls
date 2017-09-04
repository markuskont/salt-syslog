/etc/syslog-ng/syslog-ng.conf:
  file.managed:
    - mode: 644
    - source: salt://syslog/syslog-ng/files/main.jinja
    - template: jinja
    - default:
      major: {{ pillar.syslog_ng.server.version.maj }}
      minor: {{ pillar.syslog_ng.server.version.min }}

/etc/syslog-ng/conf.d/001-local-src.conf:
  file.managed:
    - mode: 644
    - source: salt://syslog/syslog-ng/files/001.jinja
    - template: jinja

/etc/syslog-ng/conf.d/005-file-dests.conf:
  file.managed:
    - mode: 644
    - source: salt://syslog/syslog-ng/files/005.jinja
    - template: jinja
