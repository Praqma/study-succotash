name 'windows_chocolatey_test'
maintainer 'The Authors'
maintainer_email 'you@example.com'
license 'all_rights'
description 'Installs/Configures windows_chocolatey_test'
long_description 'Installs/Configures windows_chocolatey_test'
version '0.1.2'

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Issues` link
# issues_url 'https://github.com/<insert_org_here>/windows_chocolatey_test/issues' if respond_to?(:issues_url)

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Source` link
# source_url 'https://github.com/<insert_org_here>/windows_chocolatey_test' if respond_to?(:source_url)

depends 'vagrant', '~> 0.6.0'
depends 'chocolatey', '~> 1.0.3'