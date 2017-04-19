{% if grains.kernel == 'Linux' %}
include:
  - syslog.rsyslog.client
{% elif grains.kernel == 'Windows' %}
include:
  - syslog.nxlog.client
{% endif %}
