# Using the knife command

This document describes how to use the `knife` command line tool from your workstation. It is part of the ChefDK.

## View node configuration

`knife node show node-name`

## Add a runlist to a node

`knife node run_list add node-name "recipe[toxiproxy]"`

## Running chef-client on a node to update it

Examples:

```
knife winrm role:role-name chef-client -V -x administrator -P changeme
knife winrm name:node-name chef-client -a ipaddress -x administrator -P changeme
```

Options explained:

- The first example uses verbose output.
- The second example finds a node by name, not by role.
- The second example uses the `ipaddress` attribute to connect to the ndoe, instead of the default `fqdn` which is the
  fully qualified domain name.

## Uploading cookbooks to Chef Server

When you have created a cookbook, you need to upload it to the Chef Server in order to make nodes use it.

Use `knife cookbook upload` instead of `knife upload cookbook`. The latter provides very poor error messages.

If you get an error that the cookbook could not be found in the cookbook path, look at the `knife.rb` configuration
file that you are using. It is most likely the one in your user home dir, e.g. `%USERPROFILE%\.chef\knife.rb`

## Downloading cookbooks from Chef Server

For local testing without Internet access to the public Chef Supermarket, you need to have dependency cookbooks in
`%USERPROFILE%\.berkshelf\cookbooks`. If the cookbook is on your Chef Server, you can download it with `knife`.

Use `knife cookbook download` instead of `knife download cookbook`, for the same reason as with `uplod` above.
