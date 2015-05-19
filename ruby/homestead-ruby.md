# Adding Ruby to Homestead

Add the following line to your `Vagrantfile`, ideally after line 17, within `Vagrant.configure` block:

`config.vm.provision :shell, path: "https://raw.githubusercontent.com/wearearchitect/guides/master/homestead_ruby.sh", privileged: false`

Then run `vagrant provision`, this will provision your box with rbenv, which will install Ruby and set it globally.

This may take a while, _you have been warned_.
