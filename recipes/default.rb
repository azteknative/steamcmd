#
# Cookbook Name:: steamcmd
# Recipe:: default
#
# Author: Peter Green <peter.green@az-tek.co.uk>
#
# Copyright (C) 2014 AzTek Native Ltd.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
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

# Increase number of file descriptors allowed for
# this user
user_ulimit "steam" do
  filehandle_limit 8192
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
remote_file "#{Chef::Config[:file_cache_path]}/steamcmd_linux.tar.gz" do
  source "http://media.steampowered.com/installer/steamcmd_linux.tar.gz"
end

directory node[:steamcmd][:install_path] do
  action :create
  owner node[:steamcmd][:user]
  group node[:steamcmd][:group]
  recursive true
end

bash "extract_steamcmd" do
  code "tar xzf #{Chef::Config[:file_cache_path]}/steamcmd_linux.tar.gz -C #{node[:steamcmd][:install_path]}"
  user node[:steamcmd][:user]
end

