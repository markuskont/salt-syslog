{% from "syslog/map.jinja" import map with context %}

include:
  - syslog.common.deps
  - syslog.user

{{ map.conf_dir }}:
  file.directory:
    {% if grains.kernel == 'Linux' %}
    - mode: 750
    {% endif %}
    - user: {{ map.user }}

{{ map.ca_dir }}:
  file.directory:
    {% if grains.kernel == 'Linux' %}
    - mode: 750
    {% endif %}
    - user: {{ map.user }}

{{ map.conf_dir }}/syslog.private:
  x509.private_key_managed:
    - bits: 4096
    - require:
      - {{ map.conf_dir }}
      {% if grains.kernel == 'Linux' %}
      - pkg: syslog.dep
      {% endif %}

{{ map.conf_dir }}/syslog.cert:
  x509.certificate_managed:
    - ca_server: {{ pillar.syslog.pki.server }}
    - signing_policy: {{ pillar.syslog.pki.policy }}
    - CN: {{ grains.fqdn }}
    - days_remaining: 30
    - backup: True
    - public_key: {{ map.conf_dir }}/syslog.private
    #- managed_private_key:
    #  - name: {{ map.conf_dir }}/syslog.private
    #  - bits: 4096
    - require:
      {% if grains.kernel == 'Linux' %}
      - pkg: syslog.dep
      {% endif %}
      - file: {{ map.conf_dir }}
      - x509: {{ map.conf_dir }}/syslog.private

{{ map.conf_dir }}/key.pem:
  file.managed:
    - source: '{{ map.conf_dir }}/syslog.private'
    - user: {{ map.user }}
    {% if grains.kernel == 'Linux' %}
    - mode: 640
    {% endif %}
    - require:
      - '{{ map.conf_dir }}/syslog.private'
      - '{{ map.conf_dir }}/syslog.cert'

{{ map.conf_dir }}/cert.pem:
  file.managed:
    - source: '{{ map.conf_dir }}/syslog.cert'
    - user: {{ map.user }}
    {% if grains.kernel == 'Linux' %}
    - mode: 644
    {% endif %}
    - require:
      - '{{ map.conf_dir }}/syslog.private'
      - '{{ map.conf_dir }}/syslog.cert'

{{ map.ca_dir }}/ca.pem:
  file.managed:
    - source:
      - salt://{{pillar.syslog.pki.server}}/files{{pillar.syslog.pki.dir}}/ca.crt

{% if grains.kernel == Linux %}
/usr/bin/c_rehash {{ map.ca_dir }}:
  cmd.run:
    - onchanges:
      - file: {{ map.ca_dir }}/ca.pem
{% endif %}
