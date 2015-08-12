lock '3.4.0'

set :application, 'app_name' # this should match the Project tag on a server
set :repo_url, 'git@git_url/project.git'

set :linked_files, fetch(:linked_files, []).push('public/robots.txt')
set :linked_dirs, fetch(:linked_dirs, []).push('vendor', 'app/storage/cache', 'app/storage/logs', 'app/storage/sessions', 'app/storage/documents')

set :keep_releases, 3

set :laravel_server_user, 'deploy'

# these is only required if you are installing gems onto the server, e.g. sass
set :rbenv_type, :system
set :rbenv_ruby, '2.2.2'
set :rbenv_map_bins, %w{gem bundle}
set :rbenv_custom_path, '/opt/rbenv'

set :ec2_access_key_id, ENV['AWS_ACCESS_KEY']
set :ec2_secret_access_key, ENV['AWS_SECRET_KEY']
set :ec2_region, %w{ eu-west-1 }

ec2_role :web, user: 'deploy', ssh_options: { auth_methods: %w(publickey) }

# obviously only set these if you are using bower/gulp/etc
set :bower_flags, "--production --silent --config.interactive=false"
set :npm_flags, "--production --silent --no-spin"

set :default_env, { path: "#{shared_path}/bin:/opt/rbenv/shims:$PATH" }

namespace :deploy do

  before :starting, 'friday:check'

  desc 'Restart application'
  task :restart do
    on roles(:web) do
      execute :sudo, :service, "php5-fpm", :restart
      execute :sudo, :service, :nginx, :reload
    end
  end

  # this is to perform a migration on the server, typically for a Laravel project
  after :updated, :migrate do
    on roles(:all) do
      within release_path do
        execute :php, :artisan, :migrate, fetch(:laravel_artisan_flags)
      end
    end
  end

  after :updated, 'gulp'

end
