node default {

  include git

  vcsrepo { '/home/vagrant/rubygems-mirror':
    ensure   => present,
    provider => git,
    source   => 'https://github.com/rubygems/rubygems-mirror.git',
    revision => 'master',
  }

  include nginx
  include postgresql::server

  import "ruby.pp"
  import "node.pp"

  # APPS
  #
  nginx::resource::upstream { 'gem_in_a_box':
    ensure  => present,
    members => [
      'localhost:3050',
      'localhost:3051',
    ],
  }

  nginx::resource::vhost { 'gems.railscamps.org':
    ensure => present,
    proxy  => 'http://gem_in_a_box',
  }

  nginx::resource::upstream { 'railscamps':
    ensure  => present,
    members => [
      'localhost:3060'
    ],
  }

  nginx::resource::vhost { 'railscamps.org':
    ensure => present,
    proxy  => 'http://railscamps',
  }

  nginx::resource::upstream { 'tweeter':
    ensure  => present,
    members => [
      'localhost:3070'
    ],
  }

  nginx::resource::vhost { 'tweeter.com':
    ensure => present,
    proxy  => 'http://tweeter',
  }

  postgresql::db { 'tweeter':
    user     => 'vagrant',
    password => postgresql_password('password', 'vagrant'),
  }

  # DNS
  #
  # include bind

  # bind::server::conf { '/etc/named.conf':
  #   listen_on_addr    => [ 'any' ],
  #   listen_on_v6_addr => [ 'any' ],
  #   forwarders        => [ '208.67.222.222', '208.67.220.220' ],
  #   allow_query       => [ 'localnets' ],
  #   zones             => {
  #     'railscamps.lan' => [
  #       'type master',
  #       'file "railscamps.lan"',
  #     ],
  #     '15.2.0.10.in-addr.arpa' => [
  #       'type master',
  #       'file "15.2.0.10.in-addr.arpa"',
  #     ],
  #   },
  # }

  # bind::server::file { 'railscamps.lan':
  #   source => 'puppet:///modules/camp/dns/railscamps.lan',
  # }

  # bind::server::file { '15.2.0.10.in-addr.arpa':
  #   source => 'puppet:///modules/camp/dns/15.2.0.10.in-addr.arpa',
  # }

  include dns::server

  # Forward Zone
  dns::zone { 'railscamps.org':
    soa => "ns1.railscamps.org",
    soa_email => 'admin.railscamps.org',
    nameservers => ["ns1"]
  }

}
