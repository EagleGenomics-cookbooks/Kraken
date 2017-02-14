source 'https://supermarket.chef.io'

def company_cookbook(name, version = '>= 0.0.0', options = {})
  cookbook(name, version, { git: "https://github.com/EagleGenomics-cookbooks/#{name}.git" }.merge(options))
end

company_cookbook 'Jellyfish'

# Use pull request for magic_shell to get filename functionality
cookbook 'magic_shell', git: 'https://github.com/cvrabie/magic_shell.git'

metadata
