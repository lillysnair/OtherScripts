#Set up script

DBHOST=localhost
DBNAME=dbname
DBUSER=dbuser
DBPASSWD=test12345


sudo apt-get update -y

sudo apt-get install git-core -y

sudo apt-get install dpkg-dev -y

git config --global color.ui true

echo '.*swp' > ~/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global

sudo apt-get install tmux -y
sudo apt-get install vim -y

sudo apt-get install build-essential -y

sudo apt-get install apache2 -y

# MySQL setup for development purposes ONLY
echo -e "\n--- Install MySQL specific packages and settings ---\n"
debconf-set-selections <<< "mysql-server mysql-server/root_password password $DBPASSWD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $DBPASSWD"
debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $DBPASSWD"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $DBPASSWD"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $DBPASSWD"
debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect none"
apt-get -y install mysql-server >> /vagrant/vm_build.log 2>&1

echo -e "\n--- Setting up our MySQL user and db ---\n"
mysql -uroot -p $DBPASSWD -e "CREATE DATABASE $DBNAME" >> /vagrant/vm_build.log 2>&1
mysql -uroot -p $DBPASSWD -e "grant all privileges on $DBNAME.* to '$DBUSER'@'localhost' identified by '$DBPASSWD'" > /vagrant/vm_build.log 2>&1


sudo apt-get install python-dev python-virtualenv python-pip -y

echo -e "\n--- Enabling mod-rewrite ---\n"
a2enmod rewrite >> /vagrant/vm_build.log 2>&1

echo -e "\n--- Allowing Apache override to all ---\n"
sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf

echo -e "\n--- Setting document root to public directory ---\n"
rm -rf /var/www/html
ln -fs /vagrant/public /var/www/html

echo -e "\n--- Restarting Apache ---\n"
#service apache2 restart >> /vagrant/vm_build.log 2>&

echo -e "Use the following commands to save changes and commit the changes: \n git commit \n git status \n git push origin master"
echo -e "\n FinishedH"
