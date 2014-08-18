# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'student_hub'
set :repo_url, 'git@github.com:Supy/studenthub.git'

set :scm, :git

role :app, %w{capistrano-deployer@studenthub.co.za}
role :web, %w{capistrano-deployer@studenthub.co.za}
role :db,  %w{capistrano-deployer@studenthub.co.za}

server 'studenthub.co.za', user: 'capistrano-deployer', roles: %w{web app db}

set :ssh_options, {
    forward_agent: true,
    port: 2222
}

after "deploy:updated", "newrelic:notice_deployment"

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart
end

namespace :figaro do
    desc 'SCP transfer Figaro application.yml configuration to the shared folder'
    task :setup do
        on roles(:app) do
            upload! 'config/application.yml', "#{shared_path}/application.yml", via: :scp
        end
    end

    desc 'Symlink application.yml to the release path'
    task :symlink do
        on roles(:app) do
            execute "ln -sf #{shared_path}/application.yml #{release_path}/config/application.yml"
        end
    end
end

# Transfer application.yml on deploy.
after 'deploy:started', 'figaro:setup'
after 'deploy:updating', 'figaro:symlink'
