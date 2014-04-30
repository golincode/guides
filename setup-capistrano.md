# Capistrano Setup

Ensure you have [Bundler](http://bundler.io) installed on your system first:

	$ gem list bundler

If you do not, run:

	$ gem install bundler

When this is installed, run the installation command:

	$ bundle install

This should install the dependencies needed to deploy the app, namely [Capistrano](http://capistranorb.com).

This will also install the Cap::Laravel gem, please follow its [documentation](https://github.com/wearearchitect/cap-laravel) to add its tasks to Capistrano's own.

To check they are in place, run `cap -vT`, you should see a list featuring the following:

	cap artisan:app:storage            # Make the storage dir more accessible
	cap artisan:db:migrate             # Perform database migrations
	cap artisan:db:refresh             # Refresh database schema
	cap artisan:db:seed[class]         # Seed the database / Seed an individual class
	cap assets:bower                   # Run the bower command
	cap assets:grunt                   # Run the grunt command
	cap assets:npm                     # Install node components
	cap composer:install               # Install composer packages
	cap composer:update                # Update installed composer packages

If there are all in the list, you are ready to deploy!

## Additional Details

The Cap::Laravel gem is setup to just run from the get-go, the tasks it runs are pre-hooked and will be fired off when performing a deploy.

The following tasks don't run by default:

- `artisan:db:refresh`
- `artisan:db:seed[class]`
- `assets:bower`
- `composer:update`

These are optional tasks, and can be performed on an ad-hoc basis.

It is possible to disable the running of migrations and compilations of assets, please consult the documentation linked earlier for instructions on how to do this.