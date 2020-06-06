{# install efs 
install nsf client:
  pkg.installed:
    - name: nfs-common

create directory for mounting:
  file.directory:
    - name: /etc/salt/pki
    - makedirs: True

mount nfs from efs:
  mount.mounted:
    - name: /etc/salt/pki
    - fstype: nfs4
    - device: fs-8fb682ce.efs.ap-southeast-1.amazonaws.com:/
    - opts: nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport
#}
{# install salt #}
install salt-api:
  pkg.installed:
    - name: salt-api

install gcc:
  pkg.installed:
    - name: gcc

install pip:
  pkg.installed:
    - name: python3-pip

install pyOpenSSL:
  pip.installed:
    - name: pyOpenSSL

install cherrypy:
  pip.installed:
    - name: CherryPy

install pymysql:
  pip.installed:
    - name: pymysql

user access:
  file.managed:
    - name: /etc/salt/master.d/access.conf
    - contents: |
        external_auth:
          pam:
            thatch:
              - 'web*':
                - test.*
                - network.*
            steve|admin.*:
              - .*
            imank:
              - '*':
                -  test.*

# create local certificate:
#   module.run:
#     - name: tls.create_self_signed_cert

cherrypy configuration:
  file.managed:
    - name: /etc/salt/master.d/cherrypy.conf
    - contents: |
        rest_cherrypy:
          port: 8000
          ssl_crt: /etc/pki/tls/certs/localhost.crt
          ssl_key: /etc/pki/tls/certs/localhost.key

syndic configuration:
  file.managed:
    - name: /etc/salt/master.d/syndic.conf
    - contents: |
        # /etc/salt/master
        order_masters: True

install mysql client:
  pkg.installed:
    - name: mysql-client

external returner configuration:
  file.managed:
    - name: /etc/salt/master.d/mysql.conf
    - contents: |
        mysql.host: 'saltreturner.ccidzvvlvexe.ap-southeast-1.rds.amazonaws.com'
        mysql.user: 'admin'
        mysql.pass: 'foobarbaz'
        mysql.db: 'saltreturner'
        mysql.port: 3306
        master_job_cache: mysql

create user:
  user.present:
    - name: imank
    - enforce_password: False
    
make sure salt-master service running:
  service.running:
    - name: salt-master
    - watch:
        - file: cherrypy configuration
        - file: user access
        - file: syndic configuration

make sure salt-api service running:
  service.running:
    - name: salt-api
    - watch:
        - file: cherrypy configuration
        - file: user access
        - file: syndic configuration


{#
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport fs-8fb682ce.efs.ap-southeast-1.amazonaws.com:/ efs  
#}

  








