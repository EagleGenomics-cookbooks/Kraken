source 'https://supermarket.chef.io'

# cookbooks on github but not on the opscode supermarket.
def company_cookbook(name, version = '>= 0.0.0', options = {})
  cookbook(name, version, { git: "git@github.com:EagleGenomics-cookbooks/#{name}.git" }.merge(options))
end

company_cookbook 'Jellyfish'
cookbook 'magic_shell', git: 'https://github.com/cvrabie/magic_shell.git'

metadata
