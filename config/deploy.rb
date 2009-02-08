set :application, "file_converter"

set :deploy_to, "/var/www/apps/#{application}"

set :scm, :git
set :repository,  "git://github.com/balepc/file_converter.git"
set :branch, "master"

#set :scm_username, "anton"
#set :scm_password, "antonpass"


#set :deploy_via, :remote_cache
set :deploy_via, :export

#set :git, "/home/deploy/bin/git"

set :user, 'deploy'
set :ssh_options, { :forward_agent => true }

ssh_options[:port] = 1488
role :app, "deploy@ekonomka.lv"
role :web, "deploy@ekonomka.lv"
role :db,  "deploy@ekonomka.lv", :primary => true
 
namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
 
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
 
  task :after_update_code, :roles => [:app] do
    copy_dblogin
    symlink_static
  end

  desc "Copy database login file to config directory"
  task :copy_dblogin, :roles => :app do
    run "cp #{shared_path}/database.yml #{release_path}/config/"
#    run "cp #{shared_path}/backup_fu.yml #{release_path}/config/"
  end

  desc "Link static images to new release"
  task :symlink_static, :roles => :app do
    run "ln -s #{shared_path}/assets #{release_path}/public/"
  end
end