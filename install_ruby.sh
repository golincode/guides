#!/usr/bin/env bash

# is git installed?
which -s git
if [[ $? != 0 ]]; then
    echo "git not installed"; exit
fi

# is rvm installed?
which -s rvm
if [[ $? == 0 ]]; then
    rvm implode
fi

# is brew installed?
which -s brew
if [[ $? != 0 ]] ; then
    git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
    if [[ -e "~/.zshrc" ]]; then
        echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
    else
        echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
    fi
    git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
else
    brew update
    brew install rbenv ruby-build
fi

if [[ -e "~/.zshrc" ]]; then
    echo 'eval "$(rbenv init -)"' >> ~/.zshrc
else
    echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
fi

git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash
git clone https://github.com/maljub01/rbenv-bundle-exec.git ~/.rbenv/plugins/rbenv-bundle-exec

rbenv install 2.1.1
rbenv global 2.1.1
