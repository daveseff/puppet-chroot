# lib/puppet/type/chroot.rb

require 'fileutils'

Puppet::Type.newtype(:chroot) do
  @doc = "Manage chroot environments"

  ensurable

  newparam(:name, :namevar=>true) do
    desc "The name of the chroot"
  end

  newparam(:path) do
    desc "The path to the chroot environment."
  end

  newparam(:userspec) do
    desc "The userspec for the chroot environment."
  end
   
  newparam(:groups) do
    desc "The groups for the chroot environment."
  end

  newparam(:exec) do
    desc "The executable to be run in the chroot environment."
  end

  validate do
    unless self[:name] and self[:path]
      raise(Puppet::Error, "Both name and path are required attributes")
    end
  end

end
