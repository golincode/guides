# Capistrano Setup

Ensure you have [Bundler](http://bundler.io) installed on your system first:

	$ gem list bundler

If you do not, run:

	$ gem install bundler

Create your Gemfile if you don't currently have one (this is targetted at deployments to AWS), it should be in your project directory:

```
# A sample Gemfile
source "https://rubygems.org"

# Other deps here, e.g. compass, sass, rake

group :development do
  gem 'capistrano', '~> 3.1'
  gem 'capistrano-laravel'
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'capistrano-rbenv', '~> 2.0'
end
```

When Bundler is installed and you have a Gemfile setup, run the installation command:

	$ bundle install

This should install the dependencies needed to deploy the app, namely [Capistrano](http://capistranorb.com).

To add Capistrano to your app, from the root of your app, run:

	$ cap install

This will 'capify' your app, and put in place the necessary files and folders, resulting in this structure added to your project:

```
.
├── Capfile
├── config
│   ├── deploy
│   │   ├── production.rb
│   │   └── staging.rb
│   └── deploy.rb
└── lib
    └── capistrano
        └── tasks
```

The main files here are `config/deploy.rb` and those in `config/deploy`.

An example `deploy.rb` can be found [here](deploy.rb).

An example environment file can be found [here](env.rb) (it has staging defaults within it).

After configuring your deployment, you can kick off a deployment with:

	$ cap ENV deploy

Where ENV is the environment you are deploying to, e.g. `staging` or `production`.
