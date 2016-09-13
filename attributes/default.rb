# kraken attributes
# We grab the latest version from github
# The reason for this is that the latest release version (v0.10.5-beta)
# installs ok, but exits with status 1 after installing, causing the chef-installation to exit
default['kraken']['src_repo'] = 'https://github.com/DerrickWood/kraken.git'
# default['kraken']['version'] = 'v0.10.5-beta' # this version has bug that causes the installation to fail, no newer tagged versions are avaiable yet so we have to use 'master'
default['kraken']['version'] = 'master'
default['kraken']['base_dir'] = '/usr/local/'
default['kraken']['src_dir'] = node['kraken']['base_dir'] + 'kraken-checkout/'
default['kraken']['install_dir'] = node['kraken']['base_dir'] + 'kraken'
