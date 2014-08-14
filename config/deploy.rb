# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'student_hub'
set :repo_url, 'git@github.com:StudentHub/studenthub.git'

set :scm, :git

role :app, %w{capistrano-deployer@studenthub.co.za}
role :web, %w{capistrano-deployer@studenthub.co.za}
role :db,  %w{capistrano-deployer@studenthub.co.za}

server 'studenthub.co.za', user: 'capistrano-deployer', roles: %w{web app db}


set :ssh_options, {
    forward_agent: true,
    port: 2222
}


namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      within release_path do
        execute :rake, 'cache:clear'
      end
    end
  end

end
