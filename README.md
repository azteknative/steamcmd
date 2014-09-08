steamcmd Cookbook
=================

The aim of this cookbook is to install the SteamCMD utility and (eventually
provide a means to install games as part of a Chef run.

This cookbook can be tested via the included Berkshelf and Vagrant configs, however there is one caveat: often when working locally, the installation of applications/games can bail out. This seems to affect longer running installations (such as CSGO) and I've not experienced this issue when working "in the cloud".

Requirements
------------
* Currently only supported on Linux, specifically: Ubuntu and CentOS.

Attributes
----------
* `[:steamcmd][:user]` - user who "owns" the installed application.
* `[:steamcmd][:group]` - primary group of the above user.
* `[:steamcmd][:additional_users]` - any additional users that should be a member of the above group.
* `[:steamcmd][:install_path]` - base installation path for the SteamCMD utility.
* `[:steamcmd][:steam_username]` - user to authenticate to the Steam service as; defaults to "anonymous".
* `[:steamcmd][:steam_passsword] - password to authenticate to the Steam servie; defaults to `nil` (necessary for anonymous auth).

Recipes
-------
### default
Takes care of the installation of the SteamCMD utility and runs it for the first time to take care of the initial download and configuration of the platform-specific components.

### csgo
Example recipe demonstrating the use of the LWRP to install Counter Strike: Global Offensive.

LWRP
----

### app
Used to manage applications/games available through the Steam platform. Currently can only manage installation via the `:install` action. For example, installing CSGO:

```
steamcmd_app "csgo" do
  action :install
  app_id 740
end
```

Usage
-----
Simply including the `steamcmd::default` recipe in your runlist will result in the SteamCMD utility
being downloaded and an initial execution of the tool in order to run through the
initial setup/config.

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Author: Peter Green

Copyright (C) 2014 AzTek Native Ltd.

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

