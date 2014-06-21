
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

