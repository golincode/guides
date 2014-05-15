# Capistrano Setup

Ensure you have [Bundler](http://bundler.io) installed on your system first:

	$ gem list bundler

If you do not, run:

	$ gem install bundler

When this is installed, run the installation command:

	$ bundle install

This should install the dependencies needed to deploy the app, namely [Capistrano](http://capistranorb.com).

To add Capistrano to your app, from the root of your app, run:

	$ cap install

This will 'capify' your app, and put in place the necessary files and folders.

After configuring your deployment, you can kick off a deployment with:

	$ cap ENV deploy

Where ENV is the environment you are deploying to, e.g. `staging` or `production`.
