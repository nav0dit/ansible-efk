

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

# Sample hosts file content :

---
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

# Tasks handled by this playbook
cluster.name: kubernetes-logger..........................................Done
node.name: `fqdn_of_host`................................................Done
network.host: `private_ip_of_host`.......................................Done
discovery.seed_hosts: `private_ip_of_host`:`transport.port`..............Done
cluster.initial_master_nodes: `fqdn_of_host`.............................Done
Disable swapping.........................................................Done
Increase file descriptors ...............................................Done
Ensure sufficient virtual memory.........................................Done
Ensure sufficient threads................................................Done
JVM DNS cache settings...................................................won'tDo
Check GC logging parameters..............................................won'tDo
Temporary directory not mounted with noexec..............................
heap.size: ???...........................................................
-XX:HeapDumpPath=`path_to_empty_directory`...............................
$ES_TMPDIR - Change path.................................................
Ansible script for both ubuntu & centos..................................
