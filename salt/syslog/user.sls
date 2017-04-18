{% from "syslog/map.jinja" import map with context %}
{% if grains.kernel == 'Linux' %}
syslog.group:
  group.present:
    - name: {{ map.group }}

syslog.user:
  user.present:
    - name: {{ map.user }}
    - shell: /bin/false
    - gid: {{ map.group }}
    - home: {{ map.home }}
    - require:
      - group: {{ map.group }}
{% endif %}
