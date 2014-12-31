#!/bin/bash

/etc/rc.d/fail2ban stop
echo Setting firewall rules...

#
# Vider les tables actuelles
iptables -t filter -F

# Vider les règles personnelles
iptables -t filter -X

# Interdire toute connexion entrante et sortante
iptables -t filter -P INPUT DROP
iptables -t filter -P FORWARD DROP
iptables -t filter -P OUTPUT DROP

# Ne pas casser les connexions etablies
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

# Autoriser loopback
iptables -t filter -A INPUT -i lo -j ACCEPT
iptables -t filter -A OUTPUT -o lo -j ACCEPT

# ICMP (Ping)
iptables -t filter -A INPUT -p icmp -j ACCEPT
iptables -t filter -A OUTPUT -p icmp -j ACCEPT

#####################################################--SSH--##################################################################

# SSH entrant
iptables -t filter -A INPUT -p tcp --dport 22 -j ACCEPT

# SSH sortant
iptables -t filter -A OUTPUT -p tcp --dport 22 -j ACCEPT

######################################################--DNS--#################################################################

# DNS entrant/sortant
iptables -t filter -A OUTPUT -p tcp --dport 53 -j ACCEPT
iptables -t filter -A OUTPUT -p udp --dport 53 -j ACCEPT
#iptables -t filter -A INPUT -p tcp --dport 53 -j ACCEPT
#iptables -t filter -A INPUT -p udp --dport 53 -j ACCEPT

######################################################--NTP--#################################################################

# NTP sortant
iptables -t filter -A OUTPUT -p udp --dport 123 -j ACCEPT

######################################################--HTTP--################################################################

# HTTP + HTTPS sortant
iptables -t filter -A OUTPUT -p tcp --dport 80 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 8080 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 443 -j ACCEPT

# HTTP + HTTPS entrant
iptables -t filter -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -t filter -A INPUT -p tcp --dport 8080 -j ACCEPT
iptables -t filter -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -t filter -A INPUT -p tcp --dport 8443 -j ACCEPT


#######################################################--FTP--################################################################

# FTP sortant
iptables -t filter -A OUTPUT -p tcp --dport 20:21 -j ACCEPT

# FTP entrant
#modprobe ip_conntrack_ftp
#modprobe ip_nat_ftp
iptables -t filter -A INPUT -p tcp --dport 20:21 -j ACCEPT
iptables -t filter -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT


#######################################################--MAIL--###############################################################

# Mail SMTP:25
#iptables -t filter -A INPUT -p tcp --dport 25 -j ACCEPT
#iptables -t filter -A OUTPUT -p tcp --dport 25 -j ACCEPT

# Mail POP3:110
#iptables -t filter -A INPUT -p tcp --dport 110 -j ACCEPT
#iptables -t filter -A OUTPUT -p tcp --dport 110 -j ACCEPT

# Mail IMAP:143
#iptables -t filter -A INPUT -p tcp --dport 143 -j ACCEPT
#iptables -t filter -A OUTPUT -p tcp --dport 143 -j ACCEPT

# Mail POP3S:995
#iptables -t filter -A INPUT -p tcp --dport 995 -j ACCEPT
#iptables -t filter -A OUTPUT -p tcp --dport 995 -j ACCEPT

#######################################################--Team-Speak--########################################################

#Le Serveur Team-Speak
#le support web
#iptables -t filter -A INPUT -p tcp --dport 14534 -j ACCEPT
#iptables -t filter -A OUTPUT -p tcp --dport 14534 -j ACCEPT
#iptables -t filter -A INPUT -p udp --dport 14534 -j ACCEPT
#iptables -t filter -A OUTPUT -p udp --dport 14534 -j ACCEPT

#Le Serveur en lui même
#iptables -t filter -A INPUT -p tcp --dport 51234 -j ACCEPT
#iptables -t filter -A OUTPUT -p tcp --dport 51234 -j ACCEPT
#iptables -t filter -A INPUT -p udp --dport 51234 -j ACCEPT
#iptables -t filter -A OUTPUT -p udp --dport 51234 -j ACCEPT

#Le port d'écoute
iptables -t filter -A INPUT -p tcp --dport 8767 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 8767 -j ACCEPT
iptables -t filter -A INPUT -p udp --dport 8767 -j ACCEPT
iptables -t filter -A OUTPUT -p udp --dport 8767 -j ACCEPT
iptables -t filter -A INPUT -p tcp --dport 8768 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 8768 -j ACCEPT
iptables -t filter -A INPUT -p udp --dport 8768 -j ACCEPT
iptables -t filter -A OUTPUT -p udp --dport 8768 -j ACCEPT

#ts3
iptables -t filter -A INPUT -p udp --dport 9987 -j ACCEPT
iptables -t filter -A OUTPUT -p udp --dport 9987 -j ACCEPT
iptables -t filter -A INPUT -p tcp --dport 30033 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 30033 -j ACCEPT
iptables -t filter -A INPUT -p tcp --dport 10011 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 10011 -j ACCEPT

#L4D
#iptables -t filter -A INPUT -p udp --dport 1200 -j ACCEPT
#iptables -t filter -A OUTPUT -p udp --dport 1200 -j ACCEPT

#iptables -t filter -A INPUT -p udp --dport 27000:27014 -j ACCEPT
#iptables -t filter -A INPUT -p udp --dport 27000:27014 -j ACCEPT

#D2
#iptables -t filter -A INPUT -p udp --dport 6112:6114 -j ACCEPT
#iptables -t filter -A OUTPUT -p udp --dport 6112:6114 -j ACCEPT
#iptables -t filter -A INPUT -p tcp --dport 6112:6114 -j ACCEPT
#iptables -t filter -A OUTPUT -p tcp --dport 6112:6114 -j ACCEPT
#iptables -t filter -A INPUT -p tcp --dport 4000 -j ACCEPT
#iptables -t filter -A OUTPUT -p tcp --dport 4000 -j ACCEPT
#iptables -t filter -A INPUT -p udp --dport 4000 -j ACCEPT
#iptables -t filter -A OUTPUT -p udp --dport 4000 -j ACCEPT
#iptables -t filter -A INPUT -p tcp --dport 8888 -j ACCEPT
#iptables -t filter -A OUTPUT -p tcp --dport 8888 -j ACCEPT
#iptables -t filter -A INPUT -p udp --dport 8888 -j ACCEPT
#iptables -t filter -A OUTPUT -p udp --dport 8888 -j ACCEPT

#MSN sortant
#iptables -t filter -A OUTPUT -p tcp --dport 1863 -j ACCEPT

########################################################################
## openvpn
########################################################################

## vpn use udp or tcp not all ! (actually use udp)
iptables -I INPUT -p udp --dport 1194 -j ACCEPT
## or
#iptables -I INPUT -p tcp --dport 1194 -j ACCEPT

## openvpn : tun mode
iptables -I INPUT -i tun0 -j ACCEPT
iptables -I FORWARD -i tun0 -j ACCEPT
iptables -I FORWARD -o tun0 -j ACCEPT
iptables -I OUTPUT -o tun0 -j ACCEPT

## openvpn : bridge mode not use
#iptables -I INPUT -i tap0 -j ACCEPT
#iptables -I FORWARD -i tap0 -j ACCEPT
#iptables -I FORWARD -o tap0 -j ACCEPT
#iptables -I OUTPUT -o tap0 -j ACCEPT
#iptables -I INPUT -i br0 -j ACCEPT
#iptables -I FORWARD -i br0 -j ACCEPT
#iptables -I OUTPUT -o br0 -j ACCEPT

/etc/rc.d/fail2ban start
echo Setting firewall rules finish !
