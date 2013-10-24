rbenv::install { "vagrant":
  group => 'vagrant',
  root  => '/home/vagrant/.rbenv',
}

rbenv::compile { "2.0.0-p247":
  user  => 'vagrant',
  group => 'vagrant',
  home  => '/home/vagrant',
  global => true,
}

# Dependecy for rubygems-mirror
rbenv::gem { "hoe-doofus":
  user => "vagrant",
  ruby => "2.0.0-p247",
}

# Dependecy for rubygems-mirror
rbenv::gem { "hoe-git":
  user => "vagrant",
  ruby => "2.0.0-p247",
}

# Dependecy for rubygems-mirror
rbenv::gem { "hoe-gemcutter":
  user => "vagrant",
  ruby => "2.0.0-p247",
}

# Dependecy for rubygems-mirror
rbenv::gem { "builder":
  user => "vagrant",
  ruby => "2.0.0-p247",
}

# Dependecy for rubygems-mirror
rbenv::gem { "net-http-persistent":
  user => "vagrant",
  ruby => "2.0.0-p247",
}

vcsrepo { '/home/vagrant/rubygems-mirror':
  ensure   => present,
  provider => git,
  source   => 'https://github.com/rubygems/rubygems-mirror.git',
  revision => 'master',
}

file { "/home/vagrant/rubygems-gems":
  ensure => "directory",
  mode    => 750,
  owner   => vagrant,
  group   => vagrant,
}

file { "/home/vagrant/.gem/.mirrorrc":
  source => 'puppet:///modules/camp/gems/mirrorrc',
  mode    => 750,
  owner   => vagrant,
  group   => vagrant,
}
