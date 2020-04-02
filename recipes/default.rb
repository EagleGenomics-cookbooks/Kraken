#
# Cookbook Name:: kraken
# Recipe:: default
#
# Copyright (c) 2016 Eagle Genomics Ltd, Apache License, Version 2.0
######################################

include_recipe 'apt' if node['platform_family'] == 'debian'

build_essential 'install essential' do
  action :install
end

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

# NOTE: the 'filename' feature is only available in a pull request version of magic_shell,
#       NOT the Chef Supermarket version. Hence a custom Berksfile entry is required.
magic_shell_environment 'PATH' do
  filename 'kraken'
  value "$PATH:#{node['kraken']['install_dir']}"
end

magic_shell_environment 'KRAKEN_VERSION' do
  value node['kraken']['version']
end
