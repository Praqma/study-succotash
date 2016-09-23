#
# Cookbook Name:: windows_chokolatey_test
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'chocolatey'

# Use the built in chocolatey_package resource to install some packages
%w{sysinternals 7zip notepadplusplus GoogleChrome}.each do |pack|
  chocolatey_package pack
end

# Include vagrant - this will make sure Vagrant is installed
include_recipe 'vagrant'
