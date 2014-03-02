# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'remotestandup'
set :repo_url, 'git@bitbucket.org:teamstatus/remotestandup.git'
set :git_shallow_clone, 1

set :ssh_options, { :forward_agent => true }

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/var/www/remotestandup.com'

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets}

set :default_env, {
  path: '/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH'
}

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
      execute :sv, 2, "/home/deployer/service/remotestandup"
      invoke 'delayed_job:restart'
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end

namespace :figaro do
  desc "SCP transfer figaro configuration to the shared folder"
  task :setup do
    on roles(:app) do
      upload! "config/application.yml", "#{shared_path}/application.yml", via: :scp
    end
  end

  desc "Symlink application.yml to the release path"
  task :symlink do
    on roles(:app) do
      execute "ln -sf #{shared_path}/application.yml #{release_path}/config/application.yml"
    end
  end
end

after "deploy:started", "figaro:setup"
before "bundler:install", "figaro:symlink"
