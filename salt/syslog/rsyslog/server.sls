{% from "syslog/map.jinja" import map with context %}

include:
  - syslog.pki.client
  - syslog.rsyslog.install
