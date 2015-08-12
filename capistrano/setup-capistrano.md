# Capistrano Setup

## Bundler

Ensure you have [Bundler](http://bundler.io) installed on your system first:

```
gem list bundler
```

If you do not, run:

```
gem install bundler
```

If your project doesn't currently have a `Gemfile`, create one with the following command (if you happen to be working on a Rails project (shock horror), it will come with one):

```
bundle init
```
By default this will generate a `Gemfile` that looks like this:

```
# A sample Gemfile
source "https://rubygems.org"

# gem "rails"
```

While the default `Gemfile` has the right idea (line 4 probably shouldn't be commented out), there are some changes that will likely need to be made:

```
source "https://rubygems.org"

# Other deps here, e.g. compass, sass, rake

group :development do
  gem 'capistrano', '~> 3.4.0'
  gem 'cap-ec2'
  gem 'capistrano-friday', '~> 0.1.0'
  gem 'airbrussh', require: false
end
```

These are the basic gems required for any deploy to our AWS setup.

As you can see, the gems are placed within the `:development` group, this means that if/when gems are installed onto a server, ones within this group are ignored.

Gems will only be installed onto the server if the `capistrano-rbenv` and `capistrano-bundler` gems are included, so if you had a gem dependency outside of `:development` like `sass`, you would need to use those gems to have it installed on the server. The former ensures the correct version of Ruby is installed on the server, the latter performs bundlers job on the server.

### Gems of note

Please follow the instructions of the individual gems if you need them:

- [capistrano-rbenv](https://github.com/capistrano/rbenv)
- [capistrano-bundler](https://github.com/capistrano/bundler)
- [capistrano-laravel](https://github.com/capistrano/laravel) (comes with composer support)
- [capistrano-npm](https://github.com/capistrano/npm)
- [capistrano-gulp](https://github.com/BRITEWEB/capistrano-gulp)
- [capistrano-grunt](https://github.com/roots/capistrano-grunt)
- [capistrano-composer](https://github.com/capistrano/composer)

_Aside: If you are working on a [Lumen](http://lumen.laravel.com/) project, the `capistrano-laravel` will not work for you._

---

When Bundler is installed and you have a `Gemfile` setup, run the installation command:

```
bundle
```

This should install the dependencies needed to deploy the app, namely [Capistrano](http://capistranorb.com).

## Capify

To add Capistrano to your app, from the root of your app, run:

```
cap install
```

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

## Capfile

Please also check the `Capfile` that is generated. For non-Rails projects, several of the files that are required will not be of use, however, there will be libs you want to load in here, such as `capistrano/rbenv`.

Whenever you add an additional Gem to the `Gemfile` for Capistrano, you will need to load it into the `Capfile`.

To check your tasks are loaded, run `cap -T` to list out the tasks Capistrano is aware of. If the list doesn't look complete, it's likely you have missed them from your `Capfile`

## Deploy

Before you deploy you should run the `ssh-add` command, this will forward your SSH key so the git repo can be accessed via your key.

After configuring your deployment, you can kick off a deployment with:

```
cap ENV deploy
```

Where ENV is the environment you are deploying to, e.g. `staging` or `production`.
