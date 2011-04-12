set :application, "file_converter"

set :deploy_to, "/var/www/apps/#{application}"

set :scm, :git       
set :repository,  "git@github.com:balepc/file_converter.git"
set :branch, "master"

set :deploy_via, :export

set :user, 'deploy'
set :ssh_options, { :forward_agent => true }

ssh_options[:port] = xxx
role :app, "deploy@xxx"
role :web, "deploy@xxx"
role :db,  "deploy@xxx", :primary => true
 
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
    run "ln -s #{shared_path}/log #{release_path}/public/"
    run "ln -s #{shared_path}/assets #{release_path}/public/"
  end
end