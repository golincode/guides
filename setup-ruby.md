# Ruby Setup

The recommended approach for managing Ruby on your system is to use **rbenv**.

## With Homebrew

I would recommend using [Homebrew](http://brew.sh) on your system to install rbenv, which is not difficult to do otherwise, but it makes installing various other components onto your system even easier.

If you have Homebrew installed, run the following:

	$ brew install rbenv ruby-build

This will but rbenv on your system, along with a means to build any rubies you want to install.

Next you need to add a line to your profile to enable the rbenv shims and autocompletion

- Mac Bash: `echo 'eval "$(rbenv init -)"' >> ~/.bash_profile`
- Linux Bash: `echo 'eval "$(rbenv init -)"' >> ~/.bashrc`
- ZSH `echo: 'eval "$(rbenv init -)"' >> ~/.zshrc`

## Without Homebrew (using Git)

If you don't have Homebrew or don't want to install it, you can do it via a bunch of Git clones:

	$ git clone https://github.com/sstephenson/rbenv.git ~/.rbenv

You then need to add the `~/.rbenv/bin` to your path:

- Mac Bash: `echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile`
- Linux Bash: `echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc`
- ZSH: `echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc`

Next you need to add a line to your profile to enable the rbenv shims and autocompletion

- Mac Bash: `echo 'eval "$(rbenv init -)"' >> ~/.bash_profile`
- Linux Bash: `echo 'eval "$(rbenv init -)"' >> ~/.bashrc`
- ZSH `echo: 'eval "$(rbenv init -)"' >> ~/.zshrc`

Then install ruby-build:

	$ git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

## Additional steps (need these for either pathway)

Install the Gem Rehash plugin, this will ensure your Ruby is rehashed after you install new Gems that provide executables, e.g. Bundler

	$ git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash

Install the Bundle Exec plugin, this will prepend `bundle exec` to certain commands to prevent peope being sad:

	$ git clone https://github.com/maljub01/rbenv-bundle-exec.git ~/.rbenv/plugins/rbenv-bundle-exec

## Installing a Ruby

Rbenv will support multiple versions of Ruby and in turn, multiple gem versions. To install a Ruby, run:

	$ rbenv install 2.1.1

When this has completed, run:

	$ rbenv global 2.1.1

This will set your global Ruby to the specified version.