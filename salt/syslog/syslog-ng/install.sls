syslog.syslog-ng.rsyslog:
  pkg.removed:
    - name: rsyslog

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
{% endif %}

{% set version_split = pillar.syslog_ng.server.version.split('.') %}
{% set major = version_split[0] %}
{% set minor = version_split[1] %}

syslog.syslog-ng.server:
  pkgrepo.managed:
    - name: syslog-ng
    - humanname: Unofficial syslog-ng repository
    - name: deb http://download.opensuse.org/repositories/home:/laszlo_budai:/syslog-ng/{{ repo }} ./
    - file: /etc/apt/sources.list.d/syslog-ng-obs.list
    - key_url: http://download.opensuse.org/repositories/home:/laszlo_budai:/syslog-ng/{{ repo }}/Release.key
  pkg.installed:
    - version: {{ pillar.syslog_ng.server.version }}
    - name: syslog-ng
    - refresh: True
  service.running:
    - name: syslog-ng
    - enable: True
    - watch:
      - file: /etc/syslog-ng/syslog-ng.conf
      - file: /etc/syslog-ng/conf.d/001-local-src.conf
      - file: /etc/syslog-ng/conf.d/005-file-dests.conf

/etc/syslog-ng/syslog-ng.conf:
  file.managed:
    - mode: 644
    - source: salt://syslog/syslog-ng/files/main.jinja
    - template: jinja
    - default:
      major: {{ major }}
      minor: {{ minor }}

/etc/syslog-ng/conf.d/001-local-src.conf:
  file.managed:
    - mode: 644
    - source: salt://syslog/syslog-ng/files/001.jinja
    - template: jinja

/etc/syslog-ng/conf.d/005-file-dests.conf:
  file.managed:
    - mode: 644
    - source: salt://syslog/syslog-ng/files/005.jinja
    - template: jinja
