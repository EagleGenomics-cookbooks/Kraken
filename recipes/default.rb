#
# Cookbook Name:: kraken
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

git node['kraken']['src_dir'] do
  repository node['kraken']['src_repo']
  revision node['kraken']['version']
  action 'checkout'
end

execute "./install_kraken.sh #{node['kraken']['install_dir']}" do
  cwd node['kraken']['src_dir']
  not_if { ::File.exist?("#{node['kraken']['install_dir']}/kraken") }
end

magic_shell_environment 'PATH' do
  value "$PATH:#{node['kraken']['install_dir']}"
end
