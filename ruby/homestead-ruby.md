# Adding Ruby to Homestead

Add the following line to your `Vagrantfile`, ideally after line 9, within `Vagrant.configure` block:

`config.vm.provision :shell, path: "https://raw.githubusercontent.com/wearearchitect/guides/master/homestead_ruby.sh", privileged: false`

The run `vagrant provision`, this will provision your box with rbenv, which will install Ruby and set it globally.

This may take a while, you have been warned.
