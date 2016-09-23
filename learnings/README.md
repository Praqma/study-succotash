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
* `kitchen destroy` to remove the instance
* `kitchen test` deletes your current instance (if any), spins up a fresh one, converges and runs integration tests, then deletes the instance again

Metadata is saved in the git-ignored `.kitchen` directory of a cookbook. You can always
delete that if for some reason you need to really start from scratch (say, you manually
deleted a VirtualBox VM).

### Best practices

#### Idempotency
Test idempotency of cookbooks at various levels. Confirm the expected result both when
running from scratch, but also when a machine is in a mixed state. For example, if you
manually uninstall a software package, is it properly reinstalled? If you remove a
downloaded file, is it properly downloaded again? If you don't, is the download or
install skipped as you would expect? And if you run `kitchen converge` on an up-to-date
system, do you indeed get `up-to-date` results only?

#### Unit testing
Unit tests are run in the pre-convergence phase, meaning they check what chef intends to do.
You won't have to test if Chef works correctly - like a package :install action triggering an attempt by chef to install.
Unit tests should be used to confirm the conditions that should be in place before chef
runs - check that your recipes are reacting correctly to different conditionals and that
Chef intends to take the correct action in different situations, by mocking different conditionals.
See [this blog post](http://jtimberman.housepub.org/blog/2015/01/12/quick-tip-testing-conditionals-in-chefspec/)
for more detail on testing conditionals. Unit tests should be very quick and ideally not take
more than a few seconds, as they purely test intentions for different conditions.

[Here's](https://sethvargo.com/unit-testing-chef-cookbooks/) another good article explaining
what you should use unit tests for in chef, and [here](http://sethvargo.github.io/chefspec/) is an introduction to ChefSpec,
one of the more popular frameworks for unit testing Chef cookbooks.

#### Integration testing
Integration testing verifies the state of the machine after converging. The integration tests should verify
that a post-convergence system is in the state you expect it to be. Integration tests should check that all
software is installed and configured as expected, and should obviously pass before anything is pushed to the chef server for deployment.
You run your integration tests either as part of a full `kitchen test` run or manually at any point by running `kitchen verify`.
Integration tests are great to run in order to verify idempotency as mentioned above, to make sure that everything behaves as it should.
These tests can be run manually in order to check that code in development works, but should most importantly
also be run as part of a CI pipeline that verifies commits.

There are several different frameworks that can be used for integration testing.
[ServerSpec]() and [InSpec](https://github.com/chef/inspec) are to be two of the more popular ones.
Chef is restructuring their tutorials to use InSpec, so it seems to be taking over. For a 
simple example of an InSpec test, have a look at the windows_chocolatey_test cookbook in this repo.

## Managing dependencies with Berkshelf
[Berkshelf](http://berkshelf.com/) is a bundler that manages cookbook dependencies. It is included in the [ChefDK](https://downloads.chef.io/chef-dk/), and is the recommended tool to use for dependency management.
When you initialize a cookbook, a Berkfile will most likely already be present.
Edit your Berkfile to include the projects your cookbook depend on, run `berks install` and `berks upload` from within the cookbook folder and any dependencies will recursively be fetched and uploaded to your chef server.
