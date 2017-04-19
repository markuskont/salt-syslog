{% from "syslog/map.jinja" import map with context %}

include:
  - syslog.pki.client
  - syslog.rsyslog.install

/etc/rsyslog.d/010-client.conf:
  file.managed:
    - mode: 644
    - source: salt://syslog/rsyslog/files/010.jinja
    - template: jinja
    - default:
      cacert: {{ map.ca_dir }}/ca.pem
      key: {{ map.conf_dir }}/key.pem
      cert: {{ map.conf_dir }}/cert.pem

syslog.rsyslog.reload-client-conf:
  cmd.run:
    - name: service rsyslog restart
    - onchanges:
      - file: /etc/rsyslog.d/010-client.conf
