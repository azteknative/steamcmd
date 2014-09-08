#
# Cookbook Name:: steamcmd
# Provider:: app
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
#
action :install do

  directory "#{new_resource.base_path}/#{new_resource.name}" do
    action :create
    user new_resource.user
    group new_resource.group
    mode "0775"
  end

  run_cli("+force_install_dir #{new_resource.base_path}/#{new_resource.name} +app_update #{new_resource.app_id} validate")

  #run_cli "install-#{new_resource.name}" do
  #  cli_args "+force_install_dir #{new_resource.base_path}/#{new_resource.name} +app_update #{new_resource.app_id}"
  #  cli_user new_resource.user
  #  steam_user new_resource.steam_user
  #  steam_password new_resource.steam_password
  #end

  #new_resource.updated_by_last_action(true)

end

def run_cli(cli_args)

  bash "run-steam-cli" do
    cwd node[:steamcmd][:install_path]
    user new_resource.user
    if new_resource.steam_password == nil
      code "./steamcmd.sh +runscript +login #{new_resource.steam_user} #{cli_args} +quit"
    else
      code "./steamcmd.sh +runscript +login #{new_resource.steam_user} #{new_resources.steam_password} #{cli_args} +quit"
    end
    timeout 7200
  end

end

