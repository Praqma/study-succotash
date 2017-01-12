# mysql_db

The purpose of the cookbook is to spin up a mysql server with a root and a non root user, create a database and import an sql dump.

This is a project that I did on the side (not for a Praqma customer), and though to share it, it might be useful.

#### Dependency management
MySQL has quite some dependencies, which is managed with the Berksfile. All the dependencies are installed from the cookbook director with `berks install`.

#### Use

1) Export an existing db to an sql dump or create an sql script with tables and some data.
2) Put this file into the files folder.
3) Upload the cookbook on your Chef server.
4) Assign it to a node.
5) Run it on the node.
6) Voila, you have a mysql server and a db up and running.

#### Attributes

The cookbook is not using data bags, for simplicity of the demo are kept in the attributes file. This needs to change to make the cookbook production ready. You can use encrypted data bags to keep your secrets safe in Chef.
