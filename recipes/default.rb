#
# Cookbook Name:: kraken
# Recipe:: default
#
# Copyright (c) 2016 Eagle Genomics Ltd, Apache License, Version 2.0
######################################

include_recipe 'apt' if node['platform_family'] == 'debian'

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

# Add Kraken to $PATH
# magic_shell will just overwrite PATH set elsewhere
# So use a ruby block...
# magic_shell_environment 'KRAKEN_PATH' do
#   environment_variable 'PATH'
#   value "$PATH:#{node['kraken']['install_dir']}"
# end

ruby_block 'add_kraken_to_PATH' do
  block do
    file = Chef::Util::FileEdit.new('/etc/profile.d/PATH.sh')
    file.insert_line_if_no_match('kraken', "export PATH=\"$PATH:#{node['kraken']['install_dir']}\"")
    file.write_file
  end
end
