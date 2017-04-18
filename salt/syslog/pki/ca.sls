include:
  - syslog.common.deps

salt-minion:
  service.running:
    - enable: True
    - listen:
      - file: /etc/salt/minion.d/signing_policies.conf

/etc/salt/minion.d/signing_policies.conf:
  file.managed:
    - source: salt://syslog/pki/files/signing_policies.jinja
    - template: jinja

{{ pillar.syslog.pki.dir }}:
  file.directory: []

{{ pillar.syslog.pki.dir }}/issued_certs:
  file.directory: []

{{ pillar.syslog.pki.dir }}/ca.key:
  x509.private_key_managed:
    - bits: 4096

{{ pillar.syslog.pki.dir }}/ca.crt:
  x509.certificate_managed:
    - signing_private_key: {{ pillar.syslog.pki.dir }}/ca.key
    - CN: {{ grains.fqdn }}
    - C: {{ pillar.syslog.pki.country }}
    - ST: {{ pillar.syslog.pki.state }}
    - L: {{ pillar.syslog.pki.location }}
    - O: {{ pillar.syslog.pki.org }}
    - basicConstraints: "critical CA:true"
    - keyUsage: "critical cRLSign, keyCertSign"
    - subjectKeyIdentifier: hash
    - authorityKeyIdentifier: keyid,issuer:always
    - days_valid: 3650
    - days_remaining: 0
    - backup: True
    - require:
      - file: {{ pillar.syslog.pki.dir }}
      - pkg: syslog.dep
      - x509: {{ pillar.syslog.pki.dir }}/ca.key

cp.push ca.crt:
  module.wait:
    - name: cp.push
    - path: {{ pillar.syslog.pki.dir }}/ca.crt
    - watch:
      - x509: {{ pillar.syslog.pki.dir }}/ca.crt

#mine.send:
#  module.run:
#    - func: x509.get_pem_entries
#    - kwargs:
#        glob_path: {{ pillar.syslog.pki.dir }}/ca.crt
#    - onchanges:
#      - x509: {{ pillar.syslog.pki.dir }}/ca.crt
