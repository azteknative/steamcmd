#
# Cookbook Name:: steamcmd
# Resource:: default
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

actions :install
default_action :install

attribute :app_title, :name_attribute => true, :kind_of => String,
            :required => true

attribute :app_id, :kind_of => Fixnum, :required => true
attribute :base_path, :kind_of => String, :default => "/usr/local/games"
attribute :user, :kind_of => String, :default => node[:steamcmd][:user]
attribute :group, :kind_of => String, :default => node[:steamcmd][:group]
attribute :steam_user, :kind_of => String, :default => node[:steamcmd][:steam_username]
attribute :steam_password, :kind_of => String, :default => node[:steamcmd][:steam_password]

