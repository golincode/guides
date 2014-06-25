git clone https://github.com/sstephenson/rbenv.git {$HOME}/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> {$HOME}/.bashrc
echo 'eval "$(rbenv init -)"' >> {$HOME}/.bashrc
git clone https://github.com/sstephenson/ruby-build.git {$HOME}/.rbenv/plugins/ruby-build
git clone https://github.com/sstephenson/rbenv-gem-rehash.git {$HOME}/.rbenv/plugins/rbenv-gem-rehash
git clone https://github.com/maljub01/rbenv-bundle-exec.git {$HOME}/.rbenv/plugins/rbenv-bundle-exec

source {$HOME}/.rbenv

rbenv install 2.1.1
rbenv global 2.1.1

gem install bundler
