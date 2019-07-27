

# Command to execute playbook
time ansible-playbook --private-key=../../ssh-keys/id_rsa -i hosts efk.yml

## To execute only play for kibana
time ansible-playbook --private-key=../../ssh-keys/id_rsa -i hosts efk.yml --tags kibana

## To execute only play for elasticsearch
time ansible-playbook --private-key=../../ssh-keys/id_rsa -i hosts efk.yml --tags elasticsearch

## To execute only play for fluentd
time ansible-playbook --private-key=../../ssh-keys/id_rsa -i hosts efk.yml --tags fluentd

## To execute whole play with single tag
time ansible-playbook --private-key=../../ssh-keys/id_rsa -i hosts efk.yml --tags efk

## Sample hosts file content :
```
all:
  hosts:
    kubemaster.testlab.nav:
    kubeminion1.testlab.nav:
    kubeminion2.testlab.nav:
  children:
    elasticsearch:
      hosts:
        kubeminion2.testlab.nav:
    kibana:
      hosts:
        kubeminion2.testlab.nav:
    kubernetes_master:
      hosts:
        kubemaster.testlab.nav:
    kubernetes_minion:
      hosts:
        kubeminion1.testlab.nav:
```

## Tasks handled by this playbook :
- [x] JAVA_HOME
- [x] cluster.name: kubernetes-logger
- [x] node.name: `fqdn_of_host`
- [x] network.host: `private_ip_of_host`
- [x] discovery.seed_hosts: `private_ip_of_host`:`transport.port`
- [x] cluster.initial_master_nodes: `fqdn_of_host`
- [x] Disable swapping
- [x] Increase file descriptors 
- [x] Ensure sufficient virtual memory
- [x] Ensure sufficient threads
- [x] heap.size: ???
- [x] -XX:HeapDumpPath=`path_to_empty_directory`
- [x] $ES_TMPDIR - Change path
- [x] Ansible script for both ubuntu & centos
- [ ] JVM DNS cache settings
- [ ] Check GC logging parameters
- [ ] Temporary directory not mounted with noexec

