# Lessons learned

## ERROR: OpenSSL::PKey::RSAError: private key needed.
This message indicates that you need to reset your key on the chef server:
* Go to your chef server, Administration, Users, Reset key
* Download the newly generated key to your .chef directory

## Setting up test-kitchen for Windows boxes and local development using Vagrant and Virtualbox
There is an official guide that uses `packer` to build base boxes here: [the learn.chef.io guide](https://learn.chef.io/local-development/windows/get-set-up/get-set-up-vagrant/).
But be aware that this may be time consuming for you.
Alternatively, see below for tests on AWS, which works out of the box.

Due to the way Windows licensing works, they cannot provide a finished Windows box, so
you might have to wait some hours for the provided image to install updates before you
have your base image ready. On top of that, some of us have experienced that after
waiting, the VM might crash and rollback all updates.
This solution works better if we have a preconfigured Windows image. But we do not have a
way of distributing it.

## Setting up test-kitchen with AWS
Now we're talking. By following [the learn.chef.io guide](https://learn.chef.io/local-development/windows/get-set-up/get-set-up-ec2/), you can setup test-kitchen to spin up fresh Windows instances for testing against.
By running `kitchen create` to initialise an instance, `kitchen converge` to apply your cookbook to the instance and troubleshoot errors, `kitchen login` to open a remote desktop connection if you need to verify something and `kitchen destroy` to remove the instance, it's very easy to test your code without affecting any static systems.

## Using test-kitchen
Test-kitchen is a great tool for testing your cookbooks locally, that is; without having
a Chef Server and nodes running `chef-client`.

First, generate a cookbook skeleton using: `chef generate cookbook my-cookbook`. That
creates a sample `.kitchen.yml` configuration file for you, which you have to adapt to a
Windows platform. Here is an example `platform` section for inspiration:

```sh
platforms:
  - name: win2012r2
    os_type: windows
    driver:
      box: eval-win2012r2-standard-nocm-1.0.4
      box_url: http://artifactory.somecustomer.com:8080/artifactory/boxes/eval-win2012r2-standard-nocm-1.0.4.box
      linked_clone: true
      guest: windows
      communicator: winrm
      gui: true
```

Use online help like http://kitchen.ci/ to get started. The basic commands you will run
from your cookbook directory are:

* `kitchen list` to see machine status
* `kitchen converge -l debug` to build and start if necessary, then apply cookbooks to test your changes
* `kitchen destroy` to test from scratch

Metadata is saved in the git-ignored `.kitchen` directory of a cookbook. You can always
delete that if for some reason you need to really start from scratch (say, you manually
deleted a VirtualBox VM).

### Best practices

Test idempotency of cookbooks at various levels. Confirm the expected result both when
running from scratch, but also when a machine is in a mixed state. For example, if you
manually uninstall a software package, is it properly reinstalled? If you remove a
downloaded file, is it properly downloaded again? If you don't, is the download or
install skipped as you would expect? And if you run `kitchen converge` on an up-to-date
system, do you indeed get `up-to-date` results only?

## Managing dependencies with Berkshelf
[Berkshelf](http://berkshelf.com/) is a bundler that manages cookbook dependencies. It is included in the [ChefDK](https://downloads.chef.io/chef-dk/), and is the recommended tool to use for dependency management.
When you initialize a cookbook, a Berkfile will most likely already be present.
Edit your Berkfile to include the projects your cookbook depend on, run `berks install` and `berks upload` from within the cookbook folder and any dependencies will recursively be fetched and uploaded to your chef server.
