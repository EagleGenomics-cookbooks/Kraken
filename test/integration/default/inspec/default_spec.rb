
# check that git checkout was successful
# is there any way to get the default attributes into this?
# using chef_run.node[][] or just node[][] does not work
describe file('/usr/local/kraken-master/install_kraken.sh') do
  it { should be_file }
end

# Check that Kraken executable is in the path
describe command('which kraken') do
  its('exit_status') { should eq 0 }
  its('stdout') { should contain('/usr/local/kraken') }
end

# Check that Kraken build executable is in the path
describe command('which kraken-build') do
  its('exit_status') { should eq 0 }
  its('stdout') { should eq 0 }
end 

# Check that kraken works
describe command('kraken --version') do
  its('exit_status') { should eq 0 }
  its('stdout') { should contain('released') }
end

# Check that kraken-build works
describe command('kraken-build --version') do
  its('exit_status') { should eq 0 }
  its('stdout') { should contain('released') }
end


