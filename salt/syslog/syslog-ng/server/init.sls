syslog.rsyslog:
  pkg.removed:
    - name: rsyslog

{% if grains.oscodename == 'Jessie' %}
  {% set repo = 'Debian_8.0' %}
{% elif grains.oscodename == 'Wheezy' %}
  {% set repo = 'Debian_7.0' %}
{% elif grains.oscodename == 'Precise' %}
  {% set repo = 'xUbuntu_12.04' %}
{% elif grains.oscodename == 'Trusty' %}
  {% set repo = 'xUbuntu_14.04' %}
{% elif grains.oscodename == 'Xenial' %}
  {% set repo = 'xUbuntu_16.04' %}
{% endif %}

syslog.syslog-ng.server:
  pkgrepo.managed:
    - name: syslog-ng
    - humanname: Unofficial syslog-ng repository
    - name: deb http://download.opensuse.org/repositories/home:/laszlo_budai:/syslog-ng/{{ repo }} ./
    - file: /etc/apt/sources.list.d/syslog-ng-obs.list
    - key_url: http://download.opensuse.org/repositories/home:/laszlo_budai:/syslog-ng/{{ repo }}/Release.key
  pkg.latest:
    - name: syslog-ng
    - refresh: True
  service.running:
    - name: syslog-ng
    - enable: True
    - watch:
      - file: /etc/syslog-ng/conf.d/00-logserver.conf

/etc/syslog-ng/conf.d/00-logserver.conf:
  file.managed:
    - mode: 644
    - source: salt://syslog/syslog-ng/server/files/00-logserver.conf
