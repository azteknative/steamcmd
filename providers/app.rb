
action :install do

  directory "#{new_resource.base_path}/#{new_resource.name}" do
    action :create
    user new_resource.user
    group new_resource.group
    mode "0775"
  end

  run_cli("+force_install_dir #{new_resource.base_path}/#{new_resource.name} +app_update #{new_resource.app_id}")

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
  end

end

