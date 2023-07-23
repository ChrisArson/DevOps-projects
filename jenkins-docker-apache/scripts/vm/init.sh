#!/bin/bash

#Check if apache2 is installed, if not then install it
dpkg -s apache2 > /dev/null
if [ $? -ne 0 ]
then
        echo "Installing apache2 service"
        sudo apt update
       	sudo apt install apache2 -y
else
	echo "Apache2 is already installed"
fi

#Extract and copy webfiles to desired dir
tar -xzvf /tmp/webfiles.tar.gz -C /tmp
sudo mv -f /tmp/data/webfiles/* /var/www/html

#Check if apache2 process is running, if not start it
if [ -f /var/run/apache2/apache2.pid ]
then
        echo "Apache2 proccess is running"
else
        echo "Apache2 process is NOT Running. Starting the process..."
        sudo systemctl start apache2 > /dev/null
        if [ $? -eq 0 ]
        then
                echo "Process started succesfully"
        else
                echo "Process starting failed"
        fi
fi
