{% from "syslog/map.jinja" import map with context %}

syslog.nxlog.install:
  pkg.latest:
    - name: nxlog
    - refresh: True
  service.running:
    - name: nxlog
    - enable: True
    - watch:
      - 'C:\Program Files (x86)\nxlog\conf\nxlog.conf'
  file.managed:
    - name: 'C:\Program Files (x86)\nxlog\conf\nxlog.conf'
    - source: salt://syslog/nxlog/files/nxlog.jinja
    - template: jinja
    - default:
      root: 'C:\\Program Files(x86)\nxlog'
      cacert: {{ map.ca_dir }}/ca.pem
      key: {{ map.conf_dir }}/key.pem
      cert: {{ map.conf_dir }}/cert.pem
