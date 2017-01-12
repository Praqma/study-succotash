# Most used Chef commands

_Found myself using this file at a client a lot, as a quick reference, it saved me a good deal of time_

In order to let the knife CLI to find your knife config (aka find your chef server), you need to be in the chef-repo to execute these commands.

    cd chef-repo

## Test your knife setup

    knife client list

  You should see the list of clients on your Chef server. If this command does not work, you cannot get the expected results from the commands below.

## Set knife to use a different knife.rb

      knife node list -c <path_to_different_knife>

  Example

    knife node list -c .chef/knife_hosted.rb

## Bootstrap a windows node

    knife bootstrap windows winrm <node name> --winrm-user <node_username> --winrm-password <password> --node-name <node name> --run-list <cookbook_name>

  Example

    knife bootstrap windows winrm jenkins_slave_node --winrm-user JenkinsSlave --winrm-password <password> --node-name jenkins_slave_node --run-list slave_ssh_keypair

## Create cookbook

    @Depricated
    knife cookbook create <cookbook_name>

    //need to be in the cookbook folder to run it or it will be generated to the wrong place
    chef generate cookbook <cookbook_name>

  Example

    chef generate cookbook mysql_db

## Upload a cookbook

    knife cookbook upload <cookbook_name>

  Example

    knife cookbook upload mysql_db


## Run the cookbooks on a node

    //need to be in the chef-repo folder to run
    knife winrm <node_name> chef-client --manual-list --winrm-user <node_username> --winrm-password <password>

  Example

    knife winrm jenkins_slave_node chef-client --manual-list --winrm-user JenkinsSlave --winrm-password <password>

## Add a cookbook to a runlist of a node

    knife node run_list add <node_name> <cookbook_name>

  Example

    knife node run_list add jenkins_slave_node 'mysql_db'
