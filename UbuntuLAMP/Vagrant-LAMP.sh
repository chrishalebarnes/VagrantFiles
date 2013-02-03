#Install and configure Apache, PHP, and MySQL
#!/bin/bash
apt-get update
apt-get --yes install apache2
apt-get --yes install php5 libapache2-mod-php5
apt-get --yes install mysql-client
#Many ways to do this: http://www.howtogeek.com/howto/30184/10-ways-to-generate-a-random-password-from-the-command-line/
password=$(</dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-16})
#Helpful: http://serverfault.com/questions/19367/scripted-install-of-mysql-on-ubuntu
echo mysql-server mysql-server/root_password select $password | debconf-set-selections
echo mysql-server mysql-server/root_password_again select $password | debconf-set-selections
apt-get --yes install mysql-server
apt-get --yes install php5-mysql

/etc/init.d/apache2 restart

echo -e "\nNetwork:"
ifconfig eth1 | grep 'inet addr:' | cut -d : -f 2-4
echo -e "\nMySQL Credentials:"
echo -e "root/$password\n"