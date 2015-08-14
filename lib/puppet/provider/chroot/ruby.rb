# lib/puppet/provider/chroot/ruby.rb
require 'fileutils'

Puppet::Type.type(:chroot).provide(:ruby) do
  desc "chroot creation."

  commands :chroot => "/usr/bin/chroot"

  def name
    resource[:name]
  end

  def path
    resource[:path]
  end

  def userspec
    resource[:userspec]
  end
 
  def groups
    resource[:groups]
  end

  def exec
    resource[:exec]
  end
  
  def create
    # copy the executable...
    if File.file? exec
      FileUtils.copy_file(exec, path + exec)
    end

    params = []
        
    unless userspec.empty?
      us = '--userspec=' + userspec
      params << us
    end

    unless groups.empty?
      g = '--groups=' + groups
      params << g
    end

    params << path
    params << exec
    
    # Run the environment
    chroot(params)
  end

  def destroy
    Puppet.debug ("Removing chroot directory " + path)
    FileUtils.rm_rf path
  end

  def exists?
    resource[:ensure] == 'present'
  end
end
