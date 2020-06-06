{% from "salt-api/map.jinja" import platform %}

install salt-minion:
  pkg.installed:
    - name: salt-minion

syndic configuration:
  file.managed:
    - name: /etc/salt/master.d/syndic.conf
    - contents: |
        # /etc/salt/master
        syndic_master: {{ platform['master01'] }}  # may be either an IP address or a hostname

minion configuration:
  file.managed:
    - name: /etc/salt/minion.d/minion.conf
    - contents: |
        id: {{ grains['id'] }}
        master: {{ grains['fqdn_ip4'][0]  }}

running salt-master service:
  service.running:
    - name: salt-master
    - watch:
        - file: syndic configuration

running salt-syndic service:
  service.running:
    - name: salt-syndic
    - watch:
        - file: syndic configuration

running salt-minion service:
  service.running:
    - name: salt-minion
    - watch:
        - file: minion configuration



  

