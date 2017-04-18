base:
  'roles:logs':
    - match: grain
    - syslog-DEVEL
  'roles:syslog-ca':
    - match: grain
    - syslog-DEVEL
  'roles:logserver':
    - match: grain
    - syslog-DEVEL
