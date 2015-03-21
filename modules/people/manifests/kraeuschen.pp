class people::kraeuschen {

  include iterm2::dev
  include slate
  include wget
  include zsh

  include chrome
  include flowdock
  include sublime_text

  include alfred
  include viscosity

  include spotify

  class { 'intellij':
    edition => 'ultimate',
    version => '14.0.3'
  }

  class { 'vagrant':
    completion => true,
    version => '1.7.2',
  }

  class { 'virtualbox':
    patch_level => '98988',
    version => '4.3.26',
  }

  $my_home  = "/Users/${::luser}"
  $projects = ["${my_home}/work", "${my_home}/private"]

  file { $projects:
    ensure => directory,
  }

  $dotfiles = "${my_home}/private/dotfiles"

  repository { $dotfiles:
    source => 'kraeuschen/dotfiles',
    notify => Exec['make-dotfiles'],
  }

  exec { 'make-dotfiles':
    command     => "cd ${dotfiles} && make",
    refreshonly => true,
  }
}
