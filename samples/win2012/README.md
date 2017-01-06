# Sample - Windows Server 2012 R2

## Purpose
The purpose of this sample is to provide a simple working chef cookbook that can be applied to a running instance of Windows Server 2012 r2.

## Prerequisites:
- VirtualBox
- Vagrant
- The Vagrant box mwrock/Windows2012R2
  - Use this repo https://github.com/mwrock/packer-templates to build the box (vbox-2012r2.json) using Packer
- A user and organization at the hosted chef server https://api.chef.io

## Up and running:
In the chef-repo prepare the .chef directory with the following files
 - knife.rb
 - [user].pem
 - [org]-validator.pem

Examine the Vagrantfile and make any changes you find necessary.

Note that by default the virtual machine will be given the ip address: 192.168.33.10. In the following this ip is refered with hostname win2012r2.local so you may consider adding it to the hosts file.

run vagrant up, and wait while vagrant prepares the virtual machine

### Bootstrap Chef:
  knife bootstrap windows winrm win2012r2.local --winrm-user vagrant --winrm-password 'vagrant' --node-name node1-win2012r2

### Verify properties
Examine the properties of the registered node
```
knife node list
knife node show node1-win2012r2
```

### Cookbook upload
Upload the cookbook and set it as the runlist for the node
```
knife cookbook upload simple_cookbook
knife node run_list set node1-win2012r2 'recipe[simple_cookbook]'
```

### Verify properties
Re-examine the new properties of the node

```knife node show node1-win2012r2```

### Run the cookbook
Finally ask chef to execute the runlist (cookbook) for the node:
```
knife winrm 'name:node1-win2012r2' chef-client --winrm-user vagrant --winrm-password 'vagrant'
```
