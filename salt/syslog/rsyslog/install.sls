syslog.rsyslog.install:
  {% if grains.oscodename == 'trusty' or grains.oscodename == 'precise'  %}
  pkgrepo.managed:
    - humanname: Rsyslog Adiscon repository
    - ppa: adiscon/v8-stable
  {% endif %}
  pkg.latest:
    - pkgs:
      - rsyslog
      - rsyslog-gnutls
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
