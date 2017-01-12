#
# Cookbook:: mysql_db
# Recipe:: default
#
# Copyright:: 2016, The Authors, All Rights Reserved.

#If this is right after creating the server, we need an update.
apt_update 'update' do
  action :update
end

# Configure the MySQL client.
mysql_client 'default' do
  action :create
end

# Configure the MySQL service.
mysql_service 'default' do
  initial_root_password node['olhus_ubuntu']['database']['root_password']
  action [:create, :start]
end

#creating the DB needs this gem
mysql2_chef_gem 'default' do
  provider Chef::Provider::Mysql2ChefGem::Mysql
  action :install
end

# MySQL connection info
mysql_connection_info = {
  :host     => node['olhus_ubuntu']['database']['host'],
  :username => node['olhus_ubuntu']['database']['root_user'],
  :password => node['olhus_ubuntu']['database']['root_password']
}

# Create a mysql database
# Script is dropping the tables, not the DB
mysql_database node['olhus_ubuntu']['database']['dbname'] do
  connection mysql_connection_info
  action :create
end

# Add a database user
mysql_database_user node['olhus_ubuntu']['database']['jenkins_username'] do
  connection mysql_connection_info
  password node['olhus_ubuntu']['database']['jenkins_password']
  database_name node['olhus_ubuntu']['database']['dbname']
  host node['olhus_ubuntu']['database']['host']
  action [:create, :grant]
end

# Create a path to the SQL file in the Chef cache.
olhus = File.join(Chef::Config[:file_cache_path], 'olhus.sql')

# Copy the SQL file from the cookbook to the Chef cache.
cookbook_file 'olhus.sql' do
  source 'olhus.sql'
  owner 'root'
  group 'root'
  mode '0600'
end

# Seed the database with a table and test data.
execute 'initialize olhus database' do
  command "mysql -h 127.0.0.1 -u jenkins -D olhus < olhus.sql"
end
