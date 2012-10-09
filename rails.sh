#Set up a Ruby on Rails EC2 Box

#Setting up Rails 3 on Amazon EC2 - Amazon Linux AMI

#Adapted from http://blog.enbake.com/setting-up-rails-3-stack-on-an-amazon-ec2-instance/
#Ideas from: http://blog.growvotes.org/2008/09/05/installing-phusion-passenger-on-a-shared-server
#Also from: http://www.ruby-forum.com/topic/90083

sudo su -

yum update -y

yum groupinstall 'Development Tools' -y
yum install readline-devel -y
yum install -y curl-devel zlib-devel openssl-devel e2fsprogs-devel krb5-devel libidn-devel

wget ftp://ftp.ruby-lang.org//pub/ruby/1.9/ruby-1.9.2-p136.tar.gz
tar xzvf ruby-1.9.2-p136.tar.gz
cd ruby-1.9.2-p136
./configure
make && make install

cd ext/zlib
ruby extconf.rb --with-zlib-include=/usr/include --with-zlib-lib=/usr/lib
make
make install

gem install --no-ri --no-rdoc rails
yum install httpd -y
yum install httpd-devel -y

yum install sqlite-devel -y
yum install postgres -y

sudo yum localinstall --nogpgcheck http://nodejs.tchol.org/repocfg/amzn1/nodejs-stable-release.noarch.rpm -y
sudo yum install nodejs-compat-symlinks npm -y

gem install --no-ri --no-rdoc passenger
passenger-install-apache2-module

echo "LoadModule passenger_module /usr/local/lib/ruby/gems/1.9.1/gems/passenger-3.0.17/ext/apache2/mod_passenger.so
PassengerRoot /usr/local/lib/ruby/gems/1.9.1/gems/passenger-3.0.17
PassengerRuby /usr/local/bin/ruby" >> /etc/httpd/conf/httpd.conf

echo "
   <VirtualHost *:80>
      ServerName galleonlabsmail.com
      # !!! Be sure to point DocumentRoot to 'public'!
      DocumentRoot /rails/intelliairmailer/public    
      <Directory /rails/intelliairmailer/public>
         # This relaxes Apache security settings.
         AllowOverride all
         # MultiViews must be turned off.
         Options -MultiViews
      </Directory>
   </VirtualHost>
" >> /etc/httpd/conf/httpd.conf

exit