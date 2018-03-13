# Class: chroot
# Examples
# --------
#
# @example
#    class { '::chroot':
#     $ensure     = present,
#     $path       = '/opt/mychroot',
#     $contents   = ['/bin', '/usr/bin', '/usr', '/usr/lib', '/usr/lib64', '/etc', '/dev', '/lib', '/lib64'],
#     $copy       = ['/etc/group', '/etc/passwd', '/etc/resolv.conf', '/etc/hosts'],
#     $exec       = '/usr/bin/cat',
#     $userspec   = 'root:root',
#     $groups     = '',
#    }
#
# Authors
# -------
#
# Max Hope <maxhopeusers.noreply.github.com>
#

# chroot class
class chroot(
  $ensure     = present,
  $path       = '/opt/mychroot',
  $contents   = ['/bin', '/usr/bin', '/usr', '/usr/lib', '/usr/lib64', '/etc', '/dev', '/lib', '/lib64'],
  $copy       = ['/etc/group', '/etc/passwd', '/etc/resolv.conf', '/etc/hosts'],
  $exec       = '/usr/bin/cat',
  $userspec   = 'root:root',
  $groups     = '',
) {

    if $ensure == 'present' {
      $dir = directory
    } else {
      $dir = absent
    }

    if $ensure == 'present' {
      # Create the chroot path 
      file {$path:
        ensure => $dir,
        owner  => 'root',
        group  => 'root',
      }->
      chroot::create_subdirs{'create_subdirs':
        path => $path,
        dirs => $contents,
      }->
      file{'/tmp/chroot_setup.sh':
        ensure  => file,
        content => template('chroot/setup_chroot.sh.erb'),
        owner   => 'root',
        group   => 'root',
        mode    => '0700',
      }->
      chroot::copy_content_to_chroot{'copy_content':
        path     => $path,
        contents => $copy,
      }->
      exec{'chroot_setup.sh':
        command     => '/tmp/chroot_setup.sh',
        path        => ['/tmp'],
        user        => 'root',
        group       => 'root',
        environment => ['PATH=/bin:/usr/bin'],
        unless      => '/usr/bin/test -f /tmp/chroot_setup',
        logoutput   => true,
      }->
      chroot {'/opt/mychroot':
        ensure   => $ensure,
        path     => $path,
        userspec => $userspec,
        groups   => $groups,
        exec     => $exec,
        require  => Exec['chroot_setup.sh'],
      }
    } else {
      file {$path:
        ensure => absent,
        owner  => 'root',
        group  => 'root',
        force  => true,
    }
  }
}
