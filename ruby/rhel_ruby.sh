#!/usr/bin/env bash

# Install yum packages
yum install -y gcc openssl-devel libyaml-devel libffi-devel readline-devel zlib-devel gdbm-devel ncurses-devel

which -s git
if [[ $? != 0 ]]; then
    echo "git not installed"; exit
else
    git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc

    git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash
    git clone https://github.com/maljub01/rbenv-bundle-exec.git ~/.rbenv/plugins/rbenv-bundle-exec

    RUBY_CONFIGURE_OPTS=--enable-shared rbenv install 2.2.0
    rbenv global 2.2.0
fi
