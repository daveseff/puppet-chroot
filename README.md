# chroot

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setupt](#setup)
    * [What chroot affects](#what-chroot-affects)
    * [Beginning with chroot](#beginning-with-chroot)
4. [Usage](#usage)
5. [Reference](#reference)
5. [Limitations](#limitations)
6. [Development](#development)

## Overview

Create and run executables in chroot environments.

## Module Description

This module setups and run executables in chroot environments.

## Setup

### What chroot affects

* chroot will create the file /tmp/chroot_setup.sh that setups the chroot environment


### Beginning with chroot

I strongly recommend you to read about the chroot command. Type 'man chroot' in you terminal. 

## Usage

You can create a chroot environment by calling the chroot class:

    class {'::chroot': 
      $ensure     = present,
      $path       = '/opt/mychroot',
      $contents   = ['/bin', '/usr/bin','/usr/lib', '/usr/lib64', '/etc', '/dev', '/lib', '/lib64'],
      $copy       = ['/etc/group', '/etc/passwd', '/etc/resolv.conf', '/etc/hosts'],
      $exec       = '/usr/bin/cat',
      $userspec   = 'root:root',
      $groups     = '',
    }

This will create a complete chroot environment and create all folders and files specified by you and also copy you executables´dependencies into the chroot environment.

If you already have a complete chroot environment, then you can use the chroot type:

    chroot {'mychroot':
       ensure     => present,
       path       => /path/to/chroot,
       userspec   => 'root:root',
       groups     => '',
       exec       => '/usr/bin/cat',
     }

## Class parameters

  * ensure   
    Setup or uninstall the chroot environment. Accepted values: [present | absent]
  * path   
    The path to your chroot environment. Ex: /opt/mychroot
  * contents    
    The folders to be created in your chroot environment. Accepted value: string array. Ex: ['/bin', '/usr/bin','/usr/lib', '/etc', '/dev', '/lib']
  * copy    
    The files to be copied to your chroot environment. Accepted value: string array. Ex: ['/etc/group', '/etc/passwd', '/etc/resolv.conf', '/etc/hosts'],
  * exec     
    The path to the executable to be run in the chroot environment. Ex:'/usr/bin/bash'
  * userspec    
    The userspec to be used when running the chroot environment. Ex: 'root:root',
  * groups    
    The additional groups to be used when running the executable in the chroot environment. Accepted value: string array. Ex: ['wheel']

## Limitations

Puppet 3.7 or above is recommended. 

## Development

Check the github repos for the code and there you can request for merges if you have maked any improvements.
