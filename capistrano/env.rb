set :stage, :staging

set :branch, 'develop'

set :deploy_to, '/var/www/site.domain.com'

# When running in production, add the '--no-interation' flag, else migrations won't take palce
set :laravel_artisan_flags, '--env=staging'

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

# When using the cap-ec2 gem
# ==========================
# When using this gem, you should delete the existing role and server definitions,
# as the gem will work out which server to deploy to based upon several tags on
# the server that match up to the attributes set in the Capistrano files.
#
# ec2_role :web, user: 'deploy', ssh_options: { auth_methods: %w(publickey) }
# ec2_role :app, user: 'deploy', ssh_options: { auth_methods: %w(publickey) }
