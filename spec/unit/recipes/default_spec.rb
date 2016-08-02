#
# Cookbook Name:: Kraken
# Spec:: default
#
# Copyright (c) 2016 Eagle Genomics Ltd, Apache License, Version 2.0.
#########################################################

require 'spec_helper'

describe 'Kraken::default' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  # default: make sure the converge works
  it 'converges successfully' do
    expect { chef_run }.to_not raise_error
  end

  # make sure the git client is installed, as this will
  # checkout the source files
  it 'includes the git client' do
    expect(chef_run).to install_git_client('default')
  end

  # make sure that git checkout is performed
  it 'performs git checkout' do
    expect(chef_run).to checkout_git(chef_run.node['Kraken']['src_dir'])
  end

  # make sure that Kraken isntall is performed
  it 'install Kraken' do
    expect(chef_run).to run_execute('./install_kraken.sh ' +   chef_run.node['Kraken']['install_dir'])
  end
  
  # make sure that the Kraken directory is added to the path
  it 'adds kraken to path' do
    expect(chef_run).to add_magic_shell_environment('PATH')
  end
end

