{% from "syslog/map.jinja" import map with context %}

include:
  - syslog.pki.client
  - syslog.syslog-ng.install

/etc/syslog-ng/conf.d/015-logserver.conf:
  file.managed:
    - mode: 644
    - source: salt://syslog/syslog-ng/files/015.jinja
    - template: jinja
#    - onchanges:
#      - service: syslog.syslog-ng.server
    - default:
      cadir: {{ map.ca_dir }}
      key: {{ map.conf_dir }}/key.pem
      cert: {{ map.conf_dir }}/cert.pem

syslog.syslog-ng.reload-logserver-conf:
  cmd.run:
    - name: service syslog-ng restart
    - onchanges:
      - file: /etc/syslog-ng/conf.d/015-logserver.conf
