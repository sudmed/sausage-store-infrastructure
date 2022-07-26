# Task confirmation

## 1. Create VMs 
**(the secret variable was left purposefully)**  
`terraform apply --auto-approve -var="IAM_token=t1.9euelZqeiZeYl42TzpOTlpiZnpWJzO3rnpWajZfNjsiPkpOKnJuVyJSSmp7l8_cdTwFp-e92dwQM_d3z9119fmj573Z3BAz9.nMwWvJaA1t4NGyOk5msuREeZBRnCulj1DszKi0yu86cT263qvKX7Bf23FMyWiG6u2NtNrfF1uxYLHWl9RcOwAw"`

```console
<...>
Plan: 2 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + vm_ip_addresses = [
      + (known after apply),
      + (known after apply),
    ]
yandex_compute_instance.vm[1]: Creating...
yandex_compute_instance.vm[0]: Creating...
yandex_compute_instance.vm[1]: Still creating... [10s elapsed]
yandex_compute_instance.vm[0]: Still creating... [10s elapsed]
yandex_compute_instance.vm[1]: Still creating... [20s elapsed]
yandex_compute_instance.vm[0]: Still creating... [20s elapsed]
yandex_compute_instance.vm[0]: Creation complete after 24s [id=fhms3lc22sr6opqbovi5]
yandex_compute_instance.vm[1]: Creation complete after 24s [id=fhm40spie6h8ahrlt9bb]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

vm_ip_addresses = [
  "chapter5-lesson2-dmitriy-pashkov-vm0 fhms3lc22sr6opqbovi5 10.128.0.81 62.84.114.21",
  "chapter5-lesson2-dmitriy-pashkov-vm1 fhm40spie6h8ahrlt9bb 10.128.0.36 51.250.81.126",
]
```

## 2. Run the 'inventory' part of ansible playbook
`ansible-playbook playbook.yaml --tags "inventory"`
```console
[WARNING]: provided hosts list is empty, only localhost is available. Note that the implicit localhost does not match 'all'

PLAY [Get IP addresses for inventory/hosts] ***************************************************************************************************************************************************
TASK [inventory : Get IP addresses for inventory/hosts file] **********************************************************************************************************************************changed: [localhost]
[WARNING]: Could not match supplied host pattern, ignoring: backend

PLAY [Deploy backend] *************************************************************************************************************************************************************************skipping: no hosts matched
[WARNING]: Could not match supplied host pattern, ignoring: frontend

PLAY [Deploy frontend] ************************************************************************************************************************************************************************skipping: no hosts matched

PLAY RECAP ************************************************************************************************************************************************************************************localhost                  : ok=1    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

## 3. Check hosts file for IP addresses
`cat inventory/hosts`
```console
[backend]
backend-vm ansible_host=62.84.114.21
[frontend]
frontend-vm ansible_host=51.250.81.126
```

## 4. Run the 'backend' part of ansible playbook
`ansible-playbook playbook.yaml --tags "backend"`
```console
PLAY [Put IP addresses into inventory/hosts] **************************************************************************************************************************************************
PLAY [Deploy backend] *************************************************************************************************************************************************************************
TASK [backend : Wait 600 seconds for target connection to become reachable/usable] ************************************************************************************************************ok: [backend-vm]

TASK [backend : Install openjdk and python] ***************************************************************************************************************************************************changed: [backend-vm]

TASK [backend : Add backend service group] ****************************************************************************************************************************************************changed: [backend-vm]

TASK [backend : Add backend service user] *****************************************************************************************************************************************************changed: [backend-vm]

TASK [backend : Create service directory] *****************************************************************************************************************************************************changed: [backend-vm]

TASK [backend : Create report directory] ******************************************************************************************************************************************************changed: [backend-vm]

TASK [backend : Create log directory] *********************************************************************************************************************************************************changed: [backend-vm]

TASK [backend : Download Maven artifact] ******************************************************************************************************************************************************changed: [backend-vm]

TASK [backend : Render the template of Sausage Store Backend Service unit] ********************************************************************************************************************changed: [backend-vm]

RUNNING HANDLER [backend : Reread systemd configs] ********************************************************************************************************************************************ok: [backend-vm]

RUNNING HANDLER [backend : Restart backend service] *******************************************************************************************************************************************changed: [backend-vm]

PLAY [Deploy frontend] ************************************************************************************************************************************************************************
PLAY RECAP ************************************************************************************************************************************************************************************backend-vm                 : ok=11   changed=9    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0 
```

## 5. Run the 'frontend' part of ansible playbook
`ansible-playbook playbook.yaml --tags "frontend"`
```console
PLAY [Put IP addresses into inventory/hosts] **************************************************************************************************************************************************
PLAY [Deploy backend] *************************************************************************************************************************************************************************
PLAY [Deploy frontend] ************************************************************************************************************************************************************************
TASK [frontend : Wait 600 seconds for target connection to become reachable/usable] ***********************************************************************************************************ok: [frontend-vm]

TASK [frontend : Collect selected facts] ******************************************************************************************************************************************************ok: [frontend-vm]

TASK [frontend : Install GPG key for NodeJS] **************************************************************************************************************************************************ok: [frontend-vm]

TASK [frontend : Install NodeJS repository] ***************************************************************************************************************************************************ok: [frontend-vm]

TASK [frontend : Install the NodeJS] **********************************************************************************************************************************************************ok: [frontend-vm]

TASK [frontend : Install node.js http-server] *************************************************************************************************************************************************ok: [frontend-vm]

TASK [frontend : Add frontend group] **********************************************************************************************************************************************************ok: [frontend-vm]

TASK [frontend : Add frontend user] ***********************************************************************************************************************************************************ok: [frontend-vm]

TASK [frontend : Create service directory] ****************************************************************************************************************************************************changed: [frontend-vm]

TASK [frontend : Create log directory] ********************************************************************************************************************************************************ok: [frontend-vm]

TASK [frontend : Download frontend from Nexus] ************************************************************************************************************************************************ok: [frontend-vm]

TASK [frontend : Extract tar.gz archive] ******************************************************************************************************************************************************changed: [frontend-vm]

TASK [frontend : Render the template of Sausage Store Frontend Service unit] ******************************************************************************************************************changed: [frontend-vm]

RUNNING HANDLER [frontend : Reread systemd configs] *******************************************************************************************************************************************ok: [frontend-vm]

RUNNING HANDLER [frontend : Restart frontend service] *****************************************************************************************************************************************changed: [frontend-vm]

PLAY RECAP ************************************************************************************************************************************************************************************frontend-vm                : ok=15   changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```


## 6. Check if it works by curl
`curl -Ik http://51.250.81.126:8080`
```console
HTTP/1.1 200 OK
accept-ranges: bytes
cache-control: max-age=3600
last-modified: Wed, 20 Jul 2022 09:13:30 GMT
etag: W/"265489-637-2022-07-20T09:13:30.000Z"
content-length: 637
content-type: text/html; charset=UTF-8
Date: Tue, 26 Jul 2022 22:48:50 GMT
Connection: keep-alive
Keep-Alive: timeout=5
```


## 7. Open in web-browser
[http://51.250.81.126:8080](http://51.250.81.126:8080)
