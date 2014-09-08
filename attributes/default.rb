#
# Cookbook Name:: steamcmd
# Attributes:: default
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

# User and group to install SteamCMD as (will be created
# if necessary)
default[:steamcmd][:user] = "steam"
default[:steamcmd][:group] = "games"

# Any additional users that should be added to the above group
default[:steamcmd][:additional_users] = []

# Install path
default[:steamcmd][:install_path] = "/usr/local/games/steamcmd"

# Default steam credentials
default[:steamcmd][:steam_username] = "anonymous"
default[:steamcmd][:steam_password] = nil

