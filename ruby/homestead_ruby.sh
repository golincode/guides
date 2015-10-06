#!/usr/bin/env bash

apt-get install -y libreadline-dev

if [[ ! -d ~/.rbenv ]]; then
  echo "Installing rbenv"
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
  echo "Adding shims / etc"
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
  echo 'eval "$(rbenv init -)"' >> ~/.bashrc
  echo "Installing ruby-build"
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
  echo "Installing Gem Rehash"
  git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash
  echo "Installing Bundle Exec"
  git clone https://github.com/maljub01/rbenv-bundle-exec.git ~/.rbenv/plugins/rbenv-bundle-exec
fi

/home/vagrant/.rbenv/bin/rbenv install -s 2.2.2
/home/vagrant/.rbenv/bin/rbenv global 2.2.2

source ~/.bashrc

/home/vagrant/.rbenv/shims/gem install bundler
