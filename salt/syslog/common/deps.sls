{% if grains.os_family == 'Debian' %}
syslog.dep:
  pkg.installed:
    - pkgs:
      - apt-transport-https
      - python-m2crypto
{% endif %}
