# Kraken attributes
# We grab the latest version from github
# The reason for this is that the latest release version (v0.10.5-beta)
# installs ok, but exits with status 1 after installing, causing the chef-installation to exit
default['Kraken']['src_repo'] = 'https://github.com/DerrickWood/kraken.git'
default['Kraken']['version'] = 'master'
default['Kraken']['base_dir'] = '/usr/local/'
default['Kraken']['src_dir'] = node['Kraken']['base_dir'] + 'kraken-master/'
default['Kraken']['install_dir'] = node['Kraken']['base_dir'] + 'Kraken'
