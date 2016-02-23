# ssh-add automation

Save the [ssh-add.plist](ssh-add.plist) file to your `~/Library/LaunchAgents` directory.

Fix the ownerships: `sudo chown root:wheel ~/Library/LaunchAgents/ssh-add.plist`

Run this command: `sudo launchctl load ~/Library/LaunchAgents/ssh-add.plist`

Now, every time you boot, `ssh-add` should be run for you!
