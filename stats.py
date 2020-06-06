import requests
host = 'https://18.139.160.18:8000'

session = requests.Session()
session.post(host + '/login', json={
    'username': 'imank',
    'password': 'imank',
    'eauth': 'pam',
}, verify=False)

# resp = session.get(host + '/stats', verify=False)
# print(resp.text)

# resp = session.get(host + '/ws/ssafsadfsdf', verify=False)
# print(resp.text)

# resp = session.get(host + '/keys', verify=False)
# print(resp.text)

# resp = session.post(host + '/hook/mycompany', json=[{
#     'foo': 'Foo!',
#     'bar': 'Bar!',
# }])
# print(resp.text)


resp = session.get(host + '/events')
print(resp.text)