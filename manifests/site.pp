import "ruby.pp"

node default {

  include git
  include nginx
  include postgresql::server

  nginx::resource::upstream { 'puppet_rack_app':
    ensure  => present,
    members => [
      'localhost:3000',
      'localhost:3001',
      'localhost:3002',
    ],
  }

  nginx::resource::vhost { 'rack.puppetlabs.com':
    ensure => present,
    proxy  => 'http://puppet_rack_app',
  }

  postgresql::db { 'tweeter':
    user     => 'vagrant',
    password => postgresql_password('password', 'vagrant'),
  }

}
