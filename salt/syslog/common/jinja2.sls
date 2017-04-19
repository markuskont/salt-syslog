syslog.common.jinja2:
  pkg.installed:
    - name: python-pip
  pip.uptodate:
    - name: jinja2
