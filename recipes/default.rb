#
# Cookbook Name:: steamcmd
# Recipe:: default
#
# Copyright 2014, AzTek Native Ltd.
#
# All rights reserved - Do Not Redistribute
#

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
  gid node[:steamcmd][:group]
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



