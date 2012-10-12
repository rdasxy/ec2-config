#!/usr/bin/bash

#Instructions from http://imperialwicket.com/aws-install-postgresql-on-amazon-linux-quick-and-dirty
#Also from http://imperialwicket.com/aws-install-postgresql-90-on-amazon-linux
#Also from http://xtremekforever.blogspot.com/2011/05/setup-rails-project-with-postgresql-on.html

sudo su -

yum update -y

yum install postgresql postgresql-server postgresql-devel postgresql-contrib postgresql-docs -y

service postgresql initdb
chkconfig postgresql on

service postgresql start

#sudo -u postgres psql postgres
#CREATE DATABASE intelliair;
#\list

exit
