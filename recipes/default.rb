#
# Cookbook Name:: Kraken
# Recipe:: default
#
# Copyright (c) 2016 Eagle Genomics Ltd, Apache License, Version 2.0
######################################

include_recipe 'apt'

include_recipe 'build-essential'

git_client 'default' do
  action :install
end

######################################

#remote_file "#{Chef::Config[:file_cache_path]}/#{node['Kraken']['zip_file']}" do
#  source node['Kraken']['download_url']
#  action :create_if_missing
#end

#execute "unzip #{Chef::Config[:file_cache_path]}/#{node['Kraken']['zip_file']} -d #{node['Kraken']['base_dir']}" do
#  not_if { ::File.exist?("#{node['Kraken']['install_script']}") }
#end

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

