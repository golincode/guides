# get apache the fuck off this system
echo "Remove Apache et al from the system"
yum -y erase httpd httpd-tools apr apr-util

# update packages and remove obsolete ones
echo "Updating..."
yum -y update

# install stuff we need, php/nginx/etc
echo "Installing required packages..."
yum install -y nginx php55 php55-cli php55-fpm php55-devel php55-common php55-mcrypt php55-mysqlnd php55-gd git

if id -u "deploy" >/dev/null 2>&1; then
	echo "User exists, skipping"
else
	echo "Creating user"
	useradd -d /home/deploy -m deploy
	mkdir /home/deploy/.ssh
	touch /home/deploy/.ssh/authorized_keys
	echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDQRmA5HU+HK0z63GAYHeJTWrFAvMeQRaJUS5kIrR+xzJfyz96zOTBEHRO0zH6OhYHTzQTdWapAdiYA4Ehf7lIXxRPvmNS2aYsRArjFa9Ct2TzeXxWZDlTgXuxS73Uj4aiiVRJCR0isB0PJcQbpUUbbcSHKeDJsL+qvZKrC+2CLHJ/5NLwvQ0ahYMkM5QY5mGrdEQWCGTd9aLoiCew9nftUDJcJsIOwCm5RY9Z+h2eA17tpuUtDYXmM6yiwnl6aSbGIKSqcMNWqLXWK6RThwBh+mnrL7Up9GIsOiocY8e3AGBuY4eRvCRrbGYchKdQx5rYF232z5zcivEdj+/DGkcrb gareth.bishop@LDNARC-NMX52VZ" >> /home/deploy/.ssh/authorized_keys
	echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCsbGLLUaiMw2JM9f9Ox7vT73kKakpcAwbyoDrb3nb2/Jofna46wvfHWPROelCAS+USZkCRx26Jj9FTxAMHxB77sEh6jwxYUw0lFNdRI0uTrsigqODpnOMNZiW2okFA6WX6jfNqqpjJiL1Ew+DQk/qCsqb85IFPkn+LqWvkw2bzba1rEaKXumJNg+w63LaCX9CzgSCQR/eNrhp7gACxQNRfw68imVS3liiROC3QEv6CeRMFq07QGs39jBBUuXC44deFxo1Xi3UT0MjS6KfoIKxUd4scPoYPif3nsG4uBXalBAoBXJKVJffKF/SHnUoiZ7nwlBZXH4PaxXkxcmmaBfVZ edward.dakin@LDNARC-DMXP00B" >> /home/deploy/.ssh/authorized_keys
	echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC/mdt1plQl6T41jVv8L/PL7ymEK3j5yLVVgQ76Lf6AV2DE1jsvD3fsNJ6dra7vGzxEd4ah3eNNm6x6YIDexPwkvOYTkkRevBAOWKWq3kVKpLCSS+zUceUv4xUl94nJAU+zhGV2PSPlyZO2SpcyntKIMLAoXxPwTZbvpq0sFEMD/dZZLkFKcWZI4mqe/jpDYL7ig3S8k3HVpbuMctBdTIHSDw1VJh5qTVheg6O7ODKnQzshPeEDp3NT7ZGubX6zZodsfXAk4uTBdOZJGW9URiJV5PpVFJMmPCf1BhyRx1B5/7DIMiiWq4o7Lx/iby7gL2Vh6Tlv8qoNn1lQ/ZRi299t adam.onishi@LDNARC-NMXN1VB" >> /home/deploy/.ssh/authorized_keys
  # refine this to what it needs
	echo "deploy	ALL=(ALL:ALL) ALL" >> /etc/sudoers
fi

# Add ll to profile
echo 'alias ll="ls -alh --color"' >> /home/deploy/.bashrc

# Make a swapfile
dd if=/dev/zero of=/swapfile bs=1024 count=512k # might be able to beef these numbers up a bit
mkswap /swapfile
swapon /swapfile
echo "/swapfile       none    swap    sw      0       0" >> /etc/fstab
echo 0 | sudo tee /proc/sys/vm/swappiness
chown root:root /swapfile
chmod 0600 /swapfile

# Make .npm dir
mkdir /home/deploy/.npm
chown deploy:deploy /home/deploy/.npm

# run stuff as deploy
su - deploy <<'EOF'
# Install nvm
export PROFILE="/home/deploy/.bashrc"
curl https://raw.githubusercontent.com/creationix/nvm/v0.23.3/install.sh | bash

# source the profile
source ~/.bashrc

# Install node
nvm install 0.12.0
nvm alias default 0.12.0

# source the profile
source ~/.bashrc

# Install grunt
npm install -g grunt-cli

# Install Ruby 2.2.0 & Bundler
curl https://raw.githubusercontent.com/wearearchitect/guides/master/ruby/rhel_ruby.sh | bash

source ~/.bashrc

gem install bundler
EOF
