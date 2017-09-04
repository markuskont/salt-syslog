syslog.syslog-ng.rsyslog:
  pkg.removed:
    - name: rsyslog

{% if grains.oscodename == 'jessie' %}
  {% set repo = 'Debian_8.0' %}
{% elif grains.oscodename == 'stretch' %}
  {% set repo = 'Debian_9.0' %}
{% elif grains.oscodename == 'wheezy' %}
  {% set repo = 'Debian_7.0' %}
{% elif grains.oscodename == 'precise' %}
  {% set repo = 'xUbuntu_12.04' %}
{% elif grains.oscodename == 'trusty' %}
  {% set repo = 'xUbuntu_14.04' %}
{% elif grains.oscodename == 'xenial' %}
  {% set repo = 'xUbuntu_16.04' %}
{% else %}
Fail - state does not support syslog-ng server on {{ grains.oscodename }}
  test.fail_without_changes
{% endif %}

syslog.syslog-ng.server:
  pkgrepo.managed:
    - name: syslog-ng
    - humanname: Unofficial syslog-ng repository
    - name: deb http://download.opensuse.org/repositories/home:/laszlo_budai:/syslog-ng/{{ repo }} ./
    - file: /etc/apt/sources.list.d/syslog-ng-obs.list
    - key_url: http://download.opensuse.org/repositories/home:/laszlo_budai:/syslog-ng/{{ repo }}/Release.key
  pkg.installed:
    - name: syslog-ng
    - refresh: True
  service.running:
    - name: syslog-ng
    - enable: True
    - watch:
      - file: /etc/syslog-ng/syslog-ng.conf
      - file: /etc/syslog-ng/conf.d/001-local-src.conf
      - file: /etc/syslog-ng/conf.d/005-file-dests.conf
