# Lessons learned

## ERROR: OpenSSL::PKey::RSAError: private key needed.
This message indicates that you need to reset your key on the chef server:
* Go to your chef server, Administration, Users, Reset key
* Download the newly generated key to your .chef directory

## Setting up test-kitchen for local development using Vagrant and Virtualbox
Don't do it. At least, not using [the learn.chef.io guide](https://learn.chef.io/local-development/windows/get-set-up/get-set-up-vagrant/).
Due to the way windows licensing works, they cannot provide a finished Windows box, so you have to wait about 5 hours for the provided image to install updates before you have your base image ready. And then after those 5 hours, the VM might crash and rollback all updates.
This solution will probably work if we can find a pre-configured Windows image. But we will have to find a way to distribute it.
Alternatively, see below for tests on AWS, which works out of the box.

## Setting up test-kitchen with AWS
Now we're talking. By following [the learn.chef.io guide](https://learn.chef.io/local-development/windows/get-set-up/get-set-up-ec2/), you can setup test-kitchen to spin up fresh Windows instances for testing against.
By running `kitchen create` to initialise an instance, `kitchen converge` to apply your cookbook to the instance and troubleshoot errors, `kitchen login` to open a remote desktop connection if you need to verify something and `kitchen destroy` to remove the instance, it's very easy to test your code without affecting any static systems. 