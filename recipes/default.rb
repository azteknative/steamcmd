#
# Cookbook Name:: steamcmd
# Recipe:: default
#
# Copyright 2014, AzTek Native Ltd.
#
# All rights reserved - Do Not Redistribute
#

if node[:platform_family] == "debian"
  include_recipe "apt"
end

# Create user and group
group node[:steamcmd][:group] do
  action :create
  if node[:steamcmd][:additional_users].length < 1
    members node[:steamcmd][:additional_users]
    append true
  end
end

user node[:steamcmd][:user] do
  action :create
  supports :manage_home => true
  gid node[:steamcmd][:group]
  home "/home/#{node[:steamcmd][:user]}"
  shell "/bin/bash"
end

# Install 32-bit compatibility libraries if necessary
if node[:kernel][:machine] == 'x86_64'
  compat_libs = value_for_platform(
    [ 'ubuntu', 'debian' ]  => {
      'default' => [ 'lib32gcc1' ]
    },
    [ 'centos', 'fedora' ] => {
      'default' => [ 'glibc.i686', 'libstdc++.i686']
    })

  compat_libs.each do |lib|
    package lib do
      action :install
    end
  end
end

# Retrieve steamcmd archive
remote_file "/tmp/steamcmd_linux.tar.gz" do
  source "http://media.steampowered.com/installer/steamcmd_linux.tar.gz"
end

directory node[:steamcmd][:install_path] do
  action :create
  owner node[:steamcmd][:user]
  group node[:steamcmd][:group]
  recursive true
end

bash "extract_steamcmd" do
  code "tar xzf /tmp/steamcmd_linux.tar.gz -C #{node[:steamcmd][:install_path]}"
  user node[:steamcmd][:user]
end

# Initial run of SteamCMD - should download and install relevant libs and tools for the
# host platform.

bash "run-steam" do
  cwd node[:steamcmd][:install_path]
  user node[:steamcmd][:user]
  code "./steamcmd.sh <<EOF
quit
EOF"
end
