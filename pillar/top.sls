base:
  'G@roles:logs and G@kernel:Linux':
    - match: compound
    - syslog-client-LINUX-DEVEL
  'G@roles:logs and G@kernel:windows':
    - match: compound
    - syslog-client-WINDOWS-DEVEL
  'roles:syslog-ca':
    - match: grain
    - syslog-DEVEL
  'roles:logserver':
    - match: grain
    - syslog-DEVEL
