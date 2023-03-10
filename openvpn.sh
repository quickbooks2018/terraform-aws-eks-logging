#!/bin/bash
# Author: Muhammad Asim
# Purpose: Setup OpenVPN in quick time.

# Docker Installation for AmazonLinux

yum install -y docker

systemctl restart docker

systemctl enable docker

#We we are pulling the best Image of docker for OpenVPN on earth.

echo -e "\nWe we are pulling the best Image of OpenVPN for docker on earth by quickbooks2018/openvpn\n"

docker pull quickbooks2018/openvpn

#Step 1

echo -e "\nStep 1\n"
sleep 1
echo -e "\nPerforming Step 1, we are going to make a directory at /root/OpenVPN/openvpn_data\n"

mkdir -p /root/OpenVPN/openvpn_data


OVPN_DATA=/root/OpenVPN/openvpn_data

echo -e "\n$OVPN_DATA\n"

export OVPN_DATA

sleep 1
read -p "Please enter your Server Main IP Address IP/DNS: " IP

echo -e "\nYour Server IP is $IP\n"

#Step 2
echo -e "\nStep 2\n"
docker run -v $OVPN_DATA:/etc/openvpn --rm quickbooks2018/openvpn ovpn_genconfig -u tcp://$IP


echo -e "\nAfter a Shortwhile You need to enter your Server Secure Password details please wait ...\n"

#Step 3
sleep 3

echo -e "\nWe are now at Step 3\n"

docker run -v $OVPN_DATA:/etc/openvpn --rm -it quickbooks2018/openvpn ovpn_initpki



#Step 4
sleep 1
echo -e "\nStep 4, We are Starting OpenVPN server process please wait ...\n"

docker run --name openvpn -p 443:1194/tcp -v $OVPN_DATA:/etc/openvpn -d  --restart unless-stopped --cap-add=NET_ADMIN quickbooks2018/openvpn

sleep 3

echo "\nSee I am up and running Alhumdulliah\n"

docker ps -a

echo -e "\nMy name is OpenVPN, I am running inside the container name OpenVPN\n"

sleep 3

#Step 5
echo -e "\nWe are now at 5th Step, Generate a client certificate with  a passphrase SAME AS YOU GIVE FOR SERVER...PASSPHRASE please wait...\n"

sleep 1
read -p "Please Provide Your Client Name " CLIENTNAME

echo -e "\nI am adding a client with name $CLIENTNAME\n"

#docker run -v $OVPN_DATA:/etc/openvpn --rm -it quickbooks2018/openvpn easyrsa build-client-full $CLIENTNAME nopass

docker run -v $OVPN_DATA:/etc/openvpn --rm -it quickbooks2018/openvpn easyrsa build-client-full $CLIENTNAME

#Step 6
echo -e "\nWe are now at 6TH Step, don't worry this is last step, you lazy GUY,Now we retrieve the client configuration with embedded certificates\n"


echo -e "\n$CLIENTNAME ok\n"

docker run -v $OVPN_DATA:/etc/openvpn --rm quickbooks2018/openvpn ovpn_getclient $CLIENTNAME > $CLIENTNAME.ovpn

#END