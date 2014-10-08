Setup Cloud Server Backups
==========================

This will help you setup backups on the Rackspace cloud servers. This is for the Architect Ubuntu-based servers.

More information (really exactly the same information as below!): http://www.rackspace.com/knowledge_center/article/rackspace-cloud-backup-install-the-agent#installubuntu

1. Step One
--------

SSH into the relevant server as root!

2. Get the agent
-------------

~~~:bash
sudo sh -c 'wget -q "http://agentrepo.drivesrvr.com/debian/agentrepo.key" -O- | apt-key add -'
~~~

3. Add the resource
----------------

~~~:bash
sudo sh -c 'echo "deb [arch=amd64] http://agentrepo.drivesrvr.com/debian/ serveragent main" > /etc/apt/sources.list.d/driveclient.list'
~~~

4. Install the agent
-----------------

~~~:bash
sudo apt-get update; sudo apt-get install driveclient
~~~

5. Configure
---------

You require the username and API key to complete the configuration. Log in to the Rackspace cloud account (https://mycloud.rackspace.com) and go to 'Account Settings'. The username and API key can be found here.

~~~:bash
sudo /usr/local/bin/driveclient --configure
~~~

6. Start the agent
---------------

~~~:bash
sudo service driveclient start
~~~

7. Set the agent to start on boot
------------------------------

~~~:bash
sudo update-rc.d driveclient defaults
~~~

8. Schedule the backup
-------------------

In the cloud account, go to 'Backup' in the main menu. The server name of the server you just installed the backup agent on will now be visible in the list. To schedule a backup, click on the server name and then on the 'Create Backup' button.



