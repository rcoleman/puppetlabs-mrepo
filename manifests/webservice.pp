# This class installs and configures apache to serve mrepo repositories.
#
# == Examples
#
# This class does not need to be directly included
#
# == Author
#
# Adrien Thebo <adrien@puppetlabs.com>
#
# == Copyright
#
# Copyright 2011 Puppet Labs, unless otherwise noted
#
class mrepo::webservice {
  include apache
  include mrepo::params

  $user  = $mrepo::params::user
  $group = $mrepo::params::group
  $docroot = $mrepo::params::www_root

  file { $docroot:
    ensure  => directory,
    owner   => $user,
    group   => $group,
    mode    => '0755',
    require => Class['apache'],
  }

  apache::vhost { "mrepo":
    priority  => "10",
    port      => "80",
    docroot   => $docroot,
    template  => "mrepo/apache.conf.erb",
  }
}
