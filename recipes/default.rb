#
# Cookbook Name:: Kraken
# Recipe:: default
#
# Copyright (c) 2016 Eagle Genomics Ltd, Apache License, Version 2.0
######################################

include_recipe 'apt'

include_recipe 'build-essential'
# jellyfish is necessary for kraken-build
include_recipe 'Jellyfish'

git_client 'default' do
  action :install
end

######################################

git node['Kraken']['src_dir'] do
  repository node['Kraken']['src_repo']
  revision node['Kraken']['version']
  action 'checkout'
end

execute "./install_kraken.sh #{node['Kraken']['install_dir']}" do
  cwd node['Kraken']['src_dir']
  not_if { ::File.exist?("#{node['Kraken']['install_dir']}/kraken") }
end

magic_shell_environment 'PATH' do
  value "$PATH:#{node['Kraken']['install_dir']}"
end
