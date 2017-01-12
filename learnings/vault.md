## Create chef-vault encrypted data bag

This approach is a mix of leaving a trace of our work in git in the form of a README file and having keys and secrets only on the server. The client keys can change any time (bootstrapping the node or regenerating key), secrets should never be in git. Please see how we achieve this.

1) Create the data_bag locally

    knife vault create <vault_name> <data_item_name> -A <admins list who get their key generated and get access to the information>

  Example

    knife vault create secret_vault slave_private_key  -A 'timea,bue'

This will create a folder in your chef-repo in the data_bags folder called <vault_name>. This folder contains 2 files <data_item_name>.json and <data_item_name>\_keys.json. The first file contains information you can find on the chef server about the <data_item_name>. The second file contains generated keys for all the admins or clients you added to your vault with the -A option. This is information that can change without being committed in git, opening the door to confusion, so please delete that one too.

2) Delete the generated files in chef-repo/data_bags/<vault_name>.

3) Create a json file with the structure of your vault.

    {
      "id": "mysql",
      "pass": <password>,
      "username": <username>
    }

It needs to have minimum an id, which will be the id of the data bag item.

Name the file the same as your <vault_name>.json.

**NOTE**: <password> and other values are only placeholders in the json file. You should keep this info in your secret server (Thycotic or similar). You only put the real secret there for the time of the upload, then replace them with placeholders. Secrets are not allowed on git.

4) Create a README.md for your vault describing why we have it, what would happen if someone deleted it.

5) Create your data_bag on chef

During the upload the plain text data in your json is being encrypted with a random string generated on the fly. We can see only the encrypted data on chef. Here is a description about what is happening exactly [https://blog.chef.io/2016/01/21/chef-vault-what-is-it-and-what-can-it-do-for-you/](https://blog.chef.io/2016/01/21/chef-vault-what-is-it-and-what-can-it-do-for-you/).

    knife vault create <vault_name> <data_item_name> --json <path_to_your_json> --mode client -A <admins list who get their key generated and get access to the information>

  Example

    knife vault create my_vault my_secret_store --json ./my_secret_store.json --mode client -A 'timea,bue'

6) Placeholders - delete the secrets and put placeholders in your local json file.

7) git add, commit, push.

## Edit the admins of an encrypted chef-vault data bag

    knife vault update <vault_name> <data_item_name> -A <admins list who get their key generated and get access to the information> -M client

  Example

    knife vault update my_vault my_secret_store -A "jan" -M client
