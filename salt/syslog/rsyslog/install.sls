{% if grains.oscodename == 'jessie' %}
  {% set repo = 'Debian_8.0' %}
{% elif grains.oscodename == 'wheezy' %}
  {% set repo = 'Debian_7.0' %}
{% elif grains.oscodename == 'Precise' %}
  {% set repo = 'xUbuntu_12.04' %}
{% elif grains.oscodename == 'trusty' %}
  {% set repo = 'xUbuntu_14.04' %}
{% elif grains.oscodename == 'xenial' %}
  {% set repo = 'xUbuntu_16.04' %}
{% else %}
Fail - state does not support syslog-ng server on {{ grains.oscodename }}
  test.fail_without_changes
{% endif %}

syslog.rsyslog.install:
  {% if grains.oscodename == 'trusty' or grains.oscodename == 'precise'  %}
  pkgrepo.managed:
    - humanname: Rsyslog Adiscon repository
    - ppa: adiscon/v8-stable
  {% endif %}
  pkg.latest:
    - pkgs:
      - rsyslog
    - refresh: True
  service.running:
    - name: rsyslog
    - enable: True
    - watch:
      - file: /etc/rsyslog.conf
      - file: /etc/rsyslog.d/002-default.conf

# Just an idea
#syslog.rsyslog.clean-config:
#  cmd.run:
#    - name: rm /etc/rsyslog.d/*.conf
#    - onchanges:
#      - pkg: syslog.rsyslog.install

# Remove default log configs
{% for file in [ '50-default', '20-ufw', '21-cloudinit' ] %}
syslog.rsyslog.remove-default-{{ file }}:
  file.absent:
    - name: /etc/rsyslog.d/{{ file }}.conf
{% endfor %}

/etc/rsyslog.conf:
  file.managed:
    - mode: 644
    - source: salt://syslog/rsyslog/files/main.jinja
    - template: jinja

/etc/rsyslog.d/002-default.conf:
  file.managed:
    - mode: 644
    - source: salt://syslog/rsyslog/files/002.jinja
    - template: jinja
