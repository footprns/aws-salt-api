import requests
import os
import json
import yaml


def get_token():
    host = 'https://18.139.160.18:8000'
    uri = '/login'
    headers = {'Accept': 'application/x-yaml'}
    payload = {'username': os.environ['SALTID'], 'password': os.environ['SALTPW'], 'eauth': 'pam'}
    r = requests.post(host + uri, verify=False, headers=headers, data=payload)
    r_dct = yaml.safe_load(r.text) # load as dictionary
    return r_dct['return'][0]['token']
    
# print(get_token())

def run_command():
    host = 'https://18.139.160.18:8000'
    # print(token)
    headers = {'Accept': 'application/x-yaml', 'X-Auth-Token': '302a83a5f7c0bdf6aedb8f123dfbc5b824180aaf'}
    payload = {'client': 'local', 'tgt': '*', 'fun': 'test.ping'}
    r = requests.post(host, verify=False, headers=headers, data=payload)
    print(r.text)
    # r_dct = yaml.safe_load(r.text) # load as dictionary
    # return r_dct['return'][0]['token']

# run_command()
'''
curl -sSk https://18.141.193.63:8000/login \
    -H 'Accept: application/x-yaml' \
    -d username=imank \
    -d password=imank \
    -d eauth=pam

curl -sSk https://18.141.193.63:8000 \
    -H 'Accept: application/x-yaml' \
    -H 'X-Auth-Token: d47e5380a8c169cec4fcf7a15053497cfd11db2b'\
    -d client=local \
    -d tgt='*' \
    -d fun=test.ping
'''
session = requests.Session()
session.post('https://18.139.160.18:8000/login', json={
    'username': 'imank',
    'password': 'imank',
    'eauth': 'pam',
}, verify=False)
'''
resp = session.post('https://18.139.160.18:8000', json=[{
    'client': 'local',
    'tgt': '*',
    'fun': 'test.arg',
    'arg': ['foo', 'bar'],
    'kwarg': {'baz': 'Baz!'},
}])
print(resp.text)

resp = session.post('https://18.139.160.18:8000', json=[{
    'client': 'local',
    'tgt': '*',
    'fun': 'test.ping',
}])
print(resp.text)

resp = session.post('https://18.139.160.18:8000', json=[{
    'client': 'local',
    'tgt': '*',
    'fun': 'test.sleep',
    'kwarg': {"length": 30},
    "timeout": 60
}])
print(resp.text)

resp = session.get('https://18.139.160.18:8000/minions')
print(resp.text)
'''
resp = session.get('https://18.139.160.18:8000/jobs')
print(resp.text)

'''
# Write the cookie file:
curl -sSk https://18.139.160.18:8000/login \
      -c ~/cookies.txt \
      -H 'Accept: application/x-yaml' \
      -d username=imank \
      -d password=imank \
      -d eauth=auto

# Read the cookie file:
curl -sSk https://localhost:8000 \
      -b ~/cookies.txt \
      -H 'Accept: application/x-yaml' \
      -d client=local \
      -d tgt='*' \
      -d fun=test.ping
'''