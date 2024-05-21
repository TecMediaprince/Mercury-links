#!/bin/bash

#Replace these with your actual interface names
PRIMARY_INTERFACE="eth0" #your primary interface
ZEROTIER_INTERFACE="zt0" #your zerotier interface

#Enable IP Forwarding
sudo sysctl -w net.ipv4.ip_forward=1

#set up NAT (Network Address Translation)
sudo iptables -t nat -A POSTROUTING -o $PRIMARY_INTERFACE -j MASQUERADE

#Allow traffic to be forwarded between interfaces
sudo iptables -A FORWARD -i $ZEROTIER_INTERFACE -o $PRIMARY_INTERFACE -j ACCEPT
sudo iptables -A FORWARD -i $PRIMARY_INTERFACE -o $ZEROTIER_INTERFACE -m --state RELATED,ESTABLISHED -j ACCEPT

#Save the iptables rules (for persistance across reboots)
sudo sh -c "iptables-save > /etc/iptables/rules.4v"

echo "IP Forwarding and NAT setup is completed successfully"