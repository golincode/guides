Setup a New Account
===================

This guide helps you setup an account on Architect’s Cloud Servers.

1. Add Record to Document
-------------------------

First, search for the spreadsheet ‘Architect Cloud Servers’ in Google Drive. Find the server you want to add an account to and create a new row.

Choose a server that has the software you need to use and the right version. If you’re using a stage and production pair, you’ll need a matching set, i.e. 5 & 6, or 7 & 8.

On production servers (even numbers), slots are numbered. Do not exceed the number of allotted slots.

On staging and test servers (odd numbers), slots are not numbered and you add a new row regardless of how many there are. If you’re going to add a production version later, make sure there’s room on the production version of the staging server you choose.

Do not mix staging and production accounts on one server.

Add the information required across the page:

- Account – the name of the account as it’s known
- Username - the username you’re going to use on the system, keep it short
- Envrionemnt – choose from ‘test’, ‘stage’ and ‘production’.
  - ‘test’ is for unstable sites or that are never designed to go live
  - ‘stage’ is for the staging version of a production site
  - ‘production’ is for the live version of a site
- Primary domain – the domain the user will end up at to visit the site
- SSH Password – the user account password
- MySQL Password – assuming the MySQL database and username is the same as the account, this would be the password
- Setup by – your name here
– Review – when the account should be reviewed to see if it’s required, always use a date. Never write ‘never’ or leave blank, that will be considered pending for deletion. A review date does not nessersarily mean it will be deleted after that, just that’ll we’ll ask the question “do we still need it?” A year’s time is a good date to choose
- Project manager – who’s looking after this account
– Fee charged – how much is being charged PCM
– Backups - note if applicable

2. Step Two
-----------

...

3. Connect to the Server
------------------------

Once you’ve chosen the server, connect to it as the `root` user over SSH. Search for the document ‘Architect Rackspace Cloud Servers’ for the passwords to each server.

~~~:bash
ssh root@architect1.wearearchitect.com
~~~

Then enter the password when prompted.

4. Create a new User
--------------------

Create the user and list their directory.

~~~:bash
useradd -d /home/username -m username
~~~

Where `username` use the user account name, e.g. `oldjamaica`.

Create a password for the user.

~~~:bash
passwd username
~~~

Where `username` use the username you just created. You’ll be prompted to write in a password twice.

Now put this username and password into the spreadsheet.

You should now change the default SSH shell to bash from sh.

~~~:bash
nano /etc/passwd
~~~

Scroll to the bottom (Control+V in Nano) and change `sh` to `bash` at the end of the line. If ZSH is available on the server, you can use `zsh`.

5. Setup Apache configuration
-----------------------------

Create a new config file with the username you just created and edit it.

~~~:bash
nano /etc/apache2/sites-available/username
~~~

Edit the file in your choice of text editor, filling in the username where appropriate.

~~~:apacheconf
<VirtualHost *:80>
    ServerAdmin admin@wearearchitect.com

    ServerName username.architectclients.com

    DocumentRoot /home/username/public
    <Directory /home/username/public>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Order allow,deny
        Allow from all
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/username-error.log

    # Possible values include: debug, info, notice, warn, error, crit,
    # alert, emerg.
    LogLevel warn

    CustomLog ${APACHE_LOG_DIR}/username-access.log combined
</VirtualHost>
~~~

Once you’ve created and saved the file, enable it.

~~~:bash
a2ensite username
~~~

Then restart Apache.

~~~:bash
service apache2 reload
~~~
