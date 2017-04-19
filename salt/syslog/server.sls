{% if 'syslog-ng-server' in grains.roles %}
include:
  - syslog.syslog-ng.server
{% elif 'rsyslog-server' in grains.roles %}
include:
  - syslog.rsyslog.server
{% endif %}
