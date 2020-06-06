import requests
# import time

session = requests.Session()
session.post('https://13.250.1.63:8000/login', json={
    'username': 'imank',
    'password': 'imank',
    'eauth': 'pam',
}, verify=False)

resp = session.post('https://13.250.1.63:8000', json=[{
    'client': 'local',
    'tgt': '*',
    'fun': 'test.ping',
}], verify=False)
print(resp.text)
# time.sleep(1)