git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash
git clone https://github.com/maljub01/rbenv-bundle-exec.git ~/.rbenv/plugins/rbenv-bundle-exec

exec $SHELL

rbenv install 2.1.1
rbenv global 2.1.1

gem install bundler
