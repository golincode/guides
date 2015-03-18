#!/bin/bash

# pass in the domain we want to create the config for
domain=$1

# check a domain arg was passed
if [ -z "$domain" ]
    then
        echo "ERR: No domain passed" 1>&2 ; exit 1;
fi

# create the folder structure
echo "creating folder structure"
mkdir -p /data/www/$domain/{current,shared,shared/node_modules,shared/public/wp-content/uploads}

# create the nginx config
echo "creating nginx site config"
cp /etc/nginx/sites-available/default.conf /etc/nginx/sites-available/$domain

# setup the config
sed -i.bak s/YOURDOMAINHERE/$domain/g /etc/nginx/sites-available/$domain

# link in the new config
ln -s /etc/nginx/sites-available/$domain /etc/nginx/sites-enabled/

# restart nginx
echo "reloading nginx"
service nginx reload

# all done
echo "END"
