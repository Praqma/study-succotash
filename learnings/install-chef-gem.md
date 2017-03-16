# Installing a Chef gem in a cookbook

## Chef and Ruby

As part of installing ChefDK you get a Ruby installation only used by Chef. It is located in an `embedded` folder,
for example `C:/opscode/chefdk/embedded/bin/` on Windows. It is used for Chef commands and has its own list of gems,
which are managed with `chef gem` instead of just `gem`.

## Use case

Writing a cookbook to set up a build agent for testing Chef cookbooks - with some extra gems required. I wanted a job
to run on commits in a cookbook repository, that would trigger a build testing the cookbook. It should run on a machine
with ChefDK installed, so it could run `kitchen test`.

However, instead of testing against a local VirtualBox on the
agent, I wanted to use an ephemeral machine on VMware vSphere. For this, I would use the
[chef-provisioning-vsphere](https://github.com/CenturyLinkCloud/chef-provisioning-vsphere) gem. This gem would be
called when running Kitchen and needed to be installed with `chef gem install` rather than `gem install`.

## Solution

The solution is described with an example here:

<http://www.hurryupandwait.io/blog/installing-user-gems-using-chef>

Typically, a plain `gem_package` installs a user gem and `chef_gem` installs a gem needed for the cookbook setup.
Here we need to use `gem_package` with some of the properties customized.
