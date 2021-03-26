---

#CREATING VM IN AZURE

- name: Create Azure VM
  hosts: "{{host}}"
  connection: local
  tasks:
  - name: Create VM with defaults
    azure_rm_virtualmachine:
      resource_group: kube
      name: "ans{{ item }}"
      admin_username: ansible
      admin_password: ansible@12345
      image:
        offer: CentOS
        publisher: OpenLogic
        sku: '7.1'
        version: latest
      vm_size: Standard_B1ls
      tags:
        env: "dev"
    loop:
      - 01
    tags:
      - createvm

#Stop the services

- name: "Stop {{web}} Service in Ansible host"
  hosts: "{{host}}"
  become: yes
  gather_facts: yes
  roles:
     - stop-service
  tags:
    - stop-service

#Restart the services

- name: "Start {{web}} Service in Ansible host"
  hosts: "{{host}}"
  become: yes
  gather_facts: yes
  roles:
     - start-service
  tags:
    - start-service

#Check the status of services
- name: "Start {{web}} Service in Ansible host"
  hosts: "{{host}}"
  become: yes
  gather_facts: yes
  roles:
     - status-service
  tags:
    - status-service

#APPLICATIONS
- name: "Check the some common application Versions"
  hosts: "{{host}}"
  become: yes
  gather_facts: yes
  roles:
     - application-status
  tags:
    - application-status

#Check some common web application service status
- name: "Check the some common application status"
  hosts: "{{host}}"
  become: yes
  gather_facts: yes
  roles:
     - web-service-status
  tags:
    - web-service-status
