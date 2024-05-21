##

# intall Zerotier on both the host and vm

in this example i have used the ubuntu 20.04

# how install the zerotier on ubuntu 20.04

curl -s https://install.zerotier.com | sudo bash

this is only is you want to join the network replace the network_id  with your actual network id

sudo zerotier-cli join <network_id>

## identify the Network interfaces
# identify the primary network interface on the host machine and the zerotier interface

## on the host machine

ip link show 

the zerotier interface is most zt********** example zt0 ,zt343  ,etc

## Enable Ip forwarding on the host machine

to allow traffic to be forwarded from the vm to the internet

sudo sysctl -w net.ipv4.ip_forward=1
sudo sh -c "echo 'net.ipv4.ip_forward' >> /etc/sysctl.confi"

## set the NAT on the Host machine

Use the iptables to set up the NAT so that the VM can use the host machine's internet connection use the setup script setup.sh

# make the script executable and run it 
chomd +x setup.sh
sudo ./setup.sh

## Configure the VM to use the zerotier network
and has a zerotier ip address 

zerotier-cli info

## set the vm defualt gatway to the hosts zerotier ip
on the vm configure the defualt gatway to route traffic through the host zerotier ip address

sudo ip route add defualt via <host_zerotier_ip>

replace the host_zerotier_ip with the zerotier ip address of your machine





