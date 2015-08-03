# Create dirs in chroot path
define chroot::create_subdirs ($path, $dirs) {
  $dirs.sort.each |$index, $dir| {
#    exec { "mkdir -p ${path}${dir}":
#      command => "mkdir -p ${path}${dir}",
#      path    => ['/bin', '/usr/bin'],
#    }

    file {"${path}${dir}":
      ensure => directory,
      owner  => 'root',
      group  => 'root',
    }
  }
}
