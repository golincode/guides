set :stage, :staging

set :branch, 'develop'

set :deploy_to, '/var/www/site.domain.com'

set :laravel_artisan_flags, '--env=staging'

set :default_env, {
  'PATH' => "#{shared_path}/bin:/opt/rbenv/shims:/usr/local/src/nvm/current/bin:$PATH"
}

# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
role :app, %w{deploy@site.domain.com}
role :web, %w{deploy@site.domain.com}

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a hash can be used to set
# extended properties on the server.
server 'site.domain.com', user: 'deploy', roles: %w{web app}
