set :application, 'mytesco'
set :repo_url, 'git@git_url/project.git'

set :scm, :git

set :format, :pretty

set :pty, true

set :linked_dirs, %w{ vendor app/storage/cache app/storage/logs app/storage/sessions app/storage/documents }

set :keep_releases, 5

set :laravel_server_user, 'deploy'

set :rbenv_type, :system
set :rbenv_ruby, '2.1.2'
set :rbenv_map_bins, %w{gem bundle}
set :rbenv_custom_path, '/opt/rbenv'

set :bower_flags, "--production --silent --config.interactive=false"
set :npm_flags, "--production --silent --no-spin"

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :updated, :migrate do
    on roles(:all) do
      within release_path do
        execute :php, :artisan, :migrate, fetch(:laravel_artisan_flags)
      end
    end
  end

  after :updated, :assets do
    on roles(:all) do
      within release_path do
        execute :bower, :install, fetch(:bower_flags)
        execute :npm, :install, fetch(:npm_flags)
        execute :grunt
      end
    end
  end

  after :published, :reload do
    on roles(:web) do
      execute :sudo, :service, "php5-fpm", :restart
      execute :sudo, :service, :nginx, :reload
    end
  end

  after :finishing, 'deploy:cleanup'

end
