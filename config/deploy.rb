# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'remotestandup'
set :repo_url, 'git@bitbucket.org:teamstatus/remotestandup.git'
set :git_shallow_clone, 1

set :ssh_options, { :forward_agent => true }

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/var/www/remotestandup.com'

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :default_env, {
  path: '/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH'
}

# after 'deploy:update_code', :upload_env_vars

# after 'deploy:setup' do
#   sudo "chown -R #{user} #{deploy_to} && chmod -R g+s #{deploy_to}"
# end

# Default value for keep_releases is 5
# set :keep_releases, 5

# require 'delayed/recipes'
# set :delayed_job_command, "bin/delayed_job"
# after "deploy:start", "delayed_job:start"
# after "deploy:stop", "delayed_job:stop"
# after "deploy:restart", "delayed_job:stop","delayed_job:start"

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
      execute :sv, 2, "/home/#{user}/service/#{application}"
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
