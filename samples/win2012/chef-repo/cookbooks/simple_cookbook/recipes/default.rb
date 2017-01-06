#
# Cookbook Name:: simple_cookbook
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

directory 'C:/temp'

template 'C:/temp/simple-info.txt' do
	  source 'simple-template.txt.erb'
end

