set :stage, :staging

set :branch, 'develop'

set :deploy_to, '/var/www/site.domain.com'

# When running in production, add the '--force' flag, else migrations won't take palce
set :laravel_artisan_flags, '--env=staging'
