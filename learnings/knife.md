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

## Data bags

- Created using `knife data bag create bag-name bag-item-name`.
- But if you omit a data bag item, it will create an empty data bag, and you cannot use `knife` to add an item
  to an existing data bag.
- You must set an `EDITOR` environment variable. If you don't, the above command will create an empty data bag and then
  fail when adding an item.

```sh
> knife data bag create licenses productx
Created data_bag[licenses]
ERROR: RuntimeError: Please set EDITOR environment variable
```

- The `EDITOR` variable cannot contain spaces or else it should be enclosed in quotes. If the value is invalid,
  you will just get the same error as above.
- As opposed to up/downloading cookbooks, for data bags you have to use the `knife upload` command.
- You download a data bags using this syntax. Notice that you have to enter a `data_bags` directory first.
  This is because of a base file path that can be seen if you run `knife download` with `-VV`:

```sh
> cd data_bags
> knife download /data_bags/bag-name
```
