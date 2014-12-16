
# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'incubator107'
set :repo_url, 'https://github.com/cip123/incubator107.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

set :use_sudo, true

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

after "deploy:update", "bluepill:quit", "bluepill:start"

namespace :bluepill do
  desc "Stop processes that bluepill is monitoring and quit bluepill"
  task :quit, :roles => [:app] do
    sudo "bluepill stop"
    sudo "bluepill quit"
  end

  desc "Load bluepill configuration and start it"
  task :start, :roles => [:app] do
    sudo "bluepill load /var/www/incubator107/current/config/production.pill"
  end

  desc "Prints bluepills monitored processes statuses"
  task :status, :roles => [:app] do
    sudo "bluepill status"
  end
end

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example
      # with RAILS_ENV: fetch(:environment) do
      #   within "#{fetch(:deploy_to)}/current/" do
      #     execute "bin/delayed_job restart 2>&1"
      #   end
      ## end

      execute "sudo service httpd restart"      
      #puts checkmark.gsub(/\\u[\da-f]{4}/i) { |m| [m[-4..-1].to_i(16)].pack('U') }.green
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  desc "task to create a symlink for the database files."
  task :copy_database_yml do
    on roles :all do
      execute "ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml"
      execute "ln -s #{shared_path}/.secret #{release_path}/.secret"
    end
  end


  after :publishing, :restart
  
  before :compile_assets, :copy_database_yml

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
     within release_path do
#      execute :bundle, :exec, :'bin/delayed_job', :restart
     end
      #  endthing such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
