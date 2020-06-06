{% from "salt-api/map.jinja" import platform %}

install salt-minion:
  pkg.installed:
    - name: salt-minion

minion configuration:
  file.managed:
    - name: /etc/salt/minion.d/minion.conf
    - contents: |
        id: {{ grains['id'] }}
        master: {{ platform['syndic01'] }}

running salt-minion service:
  service.running:
    - name: salt-minion
    - watch:
        - file: minion configuration