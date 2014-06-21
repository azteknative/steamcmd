
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

