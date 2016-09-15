# windows_chocolatey_test (and Vagrant)
The point of making this cookbook was to get acquainted with the pipeline of writing a cookbook, resolving dependencies, testing and finally deploying to a managed node through hosted Chef. The cookbook directory is saved here to provide an example of a simple cookbook along with instructions on how to use it.
This cookbook is a very simple one. It pulls down Chocolatey and Vagrant from the Chef Supermarket, installs them and then uses  chocolatey to install some example packages.

# Configuration needed to get to this point
`chef generate cookbook windows_chocolatey_test` to generate the cookbook.

#### Dependency management
`depends 'vagrant', '~> 0.6.0'` and `depends 'chocolatey', '~> 1.0.3'` was added to metadata.rb to indicate the dependencies. Nothing is changed in the Berksfile, as it is already pointing to the metadata file, and these dependencies can all be fetched from the supermarket without special configuration.

#### Test Kitchen configuration
The .kitchen.yml file is configured for a private AWS account, so kitchen commands won't work without changing the configuration. `aws_ssh_key_id` and `ssh_key` are the only unique parameters, the rest is generic AWS configuration.

You can replace the .kitchen.yml with your own preferred kitchen configuration, for example Vagrant, and it should work right away.

#### .chef/ folder with server configuration
When running commands that use a chef server, chef will recursively look up for a .chef/ folder, where knife.rb and .pem keys are stored. In my case, I have it placed at ~/.chef/. If you are trying this from a docker container, you will have to make sure to mount this folder.
knife.rb and .pem keys are both downloaded from https://api.chef.io/organizations/analogic. 

knife.rb from Administration -> Organizations -> Generate Knife Config

.pem key from Administration -> Users -> Reset Key.

#### Writing the recipe
The recipe is a very simple one, [default.rb](./default.rb), and should be pretty self-explanatory.

#### Deploying "locally" with test kitchen
`kitchen converge` sets up machine and applies the cookbook. You will see a log of any errors that happen.

`kitchen login` will remote into your test instance so you can try out if things work as expected directly on the machine.

#### Uploading and deploying
`berks install` fetches and saves all dependencies locally.
`berks upload` Pushes all dependencies to the server.

From [chef manage](https://api.chef.io/organizations/analogic/nodes/), it is now possible to change the run list to include windows_chocolatey_test