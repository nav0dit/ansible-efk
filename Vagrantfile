# -*- mode: ruby -*-
# vi: set ft=ruby :


# README
#
# Getting Started:
# 1. vagrant plugin install vagrant-hostmanager
# 2. vagrant up
# 3. vagrant ssh


Vagrant.configure("2") do |config|

  # Used for automatic host entries into launched VMs
  config.hostmanager.enabled = true

  def defaultVMProvider(targetvm, sDiskName, portNumber)
      targetvm.memory = 2048
      targetvm.cpus = 2
      targetvm.linked_clone = true
      #targetvm.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      #targetvm.customize ["modifyvm", :id, "--cableconnected1", "on"]
      #targetvm.customize ["modifyvm", :id, "--ioapic", "on"]
      unless File.exist?(sDiskName)
        targetvm.customize ['createhd', '--filename', sDiskName, '--variant', 'Fixed', '--size', 5 * 1024]
      end
      targetvm.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', portNumber, '--device', 0, '--type', 'hdd', '--medium', sDiskName]
  end

  def defaultVMConf(targetvm, sIpAddress, nGuestPort, nHostPort)
    targetvm.vm.network "private_network", ip: sIpAddress, netmask: "255.255.255.0"
    #targetvm.vm.network "forwarded_port", guest: nGuestPort, host: nHostPort, auto_correct: true
    targetvm.ssh.username = "vagrant"
    targetvm.vm.synced_folder ".", "/vagrant", type: "nfs", nfs_export: true, nfs_udp: false, nfs_version: 4
    targetvm.vm.boot_timeout = 420
    targetvm.vm.box_check_update = false
    targetvm.vm.communicator = "ssh"
    targetvm.vm.graceful_halt_timeout = 60
  end

  config.vm.provision "commonInitialSetup", type: "shell", privileged: true do |p1|
    p1.inline = "/vagrant/commonInitialSetup.sh"
  end

  config.vm.define "machine1" do |machine|
    machine.vm.box = "centos/7"
    machine.vm.hostname = "machine1.testlab.nav"
    machine.ssh.insert_key = false
    machine.vm.provider :virtualbox do |v|
      #v.customize ['storagectl', :id, '--add', 'sata', '--controller', 'IntelAHCI', '--name', 'SATA Controller']
      (1..2).each do |i|
        defaultVMProvider(v, "./machine1_extraDisk#{i}.vdi", "#{i}")
      end
    end
    defaultVMConf(machine, "192.168.55.91", 8080, 6060)
  end

  config.vm.define "machine2" do |machine|
    machine.vm.box = "centos/7"
    machine.vm.hostname = "machine2.testlab.nav"
    machine.ssh.insert_key = false
    machine.vm.provider :virtualbox do |v|
      #v.customize ['storagectl', :id, '--add', 'sata', '--controller', 'IntelAHCI', '--name', 'SATA Controller']
      defaultVMProvider(v, "./machine2_extraDisk1.vdi", 1)
    end
    defaultVMConf(machine, "192.168.55.92", 8080, 6060)
  end

  config.vm.define "machine3" do |machine|
    machine.vm.box = "centos/7"
    machine.vm.hostname = "machine3.testlab.nav"
    machine.ssh.insert_key = false
    machine.vm.provider :virtualbox do |v|
      #v.customize ['storagectl', :id, '--add', 'sata', '--controller', 'IntelAHCI', '--name', 'SATA Controller']
      defaultVMProvider(v, "./machine3_extraDisk1.vdi", 1)
    end
    defaultVMConf(machine, "192.168.55.93", 8080, 6060)
  end

end
