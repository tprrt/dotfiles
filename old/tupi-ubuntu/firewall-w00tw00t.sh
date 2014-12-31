 #!/bin/bash

########################################################################
## title : iptables rules script
## author : pantoufle@tupi.fr
## licence : AGPL v3
########################################################################

########################################################################
## Stop fail2ban before upgrade rules
########################################################################
 /etc/init.d/fail2ban stop
 echo Setting firewall rules...

########################################################################
## Remove all tables
########################################################################
 iptables -t filter -F

########################################################################
## Remove all personal rules
########################################################################
 iptables -t filter -X

########################################################################
## Before all new rules, init rules to drop w00tbot
########################################################################

 ## Accept loopback
 iptables -A INPUT -i lo -j ACCEPT

 # vérifie si l'IP est déjà présente dans la liste w00tlist.
 # Si c'est la cas, on la rejette immédiatement, met à jour la liste et
 # l'attaquant est de nouveau blacklisté pour 6h :
 iptables -A INPUT -p tcp -m recent --name w00tlist --update --seconds 21600 -j DROP

 # création de la chaine w00tchain qui rajoute l'IP
 # à la liste w00tlist et reset la connexion (ne pas oublier le paramètre
 # '-p tcp' indispensable pour l'utilisation de '--reject-with tcp-reset') :
 iptables -N w00tchain
 iptables -A w00tchain -m recent --set --name w00tlist -p tcp \
     -j REJECT --reject-with tcp-reset

 # création de notre chaîne w00t :
 iptables -N w00t

 # redirige les paquets TCP sur notre chaîne :
 iptables -A INPUT -p tcp -j w00t

########################################################################
## Personal rules for iptables
########################################################################
 iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
 

 ## Drop all connection
 iptables -t filter -P INPUT DROP
 iptables -t filter -P FORWARD DROP
 iptables -t filter -P OUTPUT DROP

 ## Save established connection
 iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
 iptables -A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

 ## Accept connection loopback
 iptables -t filter -A INPUT -i lo -j ACCEPT
 iptables -t filter -A OUTPUT -o lo -j ACCEPT


########################################################################
## Drop all scan XMAS and NULL
########################################################################
 iptables -A INPUT -p tcp --tcp-flags FIN,URG,PSH FIN,URG,PSH -j DROP
 
 iptables -A INPUT -p tcp --tcp-flags ALL ALL -j DROP
 
 iptables -A INPUT -p tcp --tcp-flags ALL NONE -j DROP
 
 iptables -A INPUT -p tcp --tcp-flags SYN,RST SYN,RST -j DROP

########################################################################
## Drop all brodcast package
########################################################################
 iptables -A INPUT -m pkttype --pkt-type broadcast -j DROP

########################################################################
## GLUSTER FS : Accep all package of server1.tupi.fr
########################################################################
 
 ## for server2.tupi.fr : accept all server1 connection
 #iptables -t filter -A INPUT -i eth0  -s 91.121.159.159 -j ACCEPT
 #iptables -t filter -A OUTPUT -o eth0 -s 91.121.159.159 -j ACCEPT

 ## for server1.tupi.fr : accept all server2 connection
 iptables -t filter -A INPUT -i eth0 -s 91.121.93.226 -j ACCEPT
 iptables -t filter -A OUTPUT -o eth0 -s 91.121.93.226 -j ACCEPT

########################################################################
## ICMP (Ping)
########################################################################
 iptables -t filter -A INPUT -p icmp -j ACCEPT
 iptables -t filter -A OUTPUT -p icmp -j ACCEPT

########################################################################
## SSH
########################################################################
 iptables -t filter -A INPUT -p tcp --dport 22 -j ACCEPT
 iptables -t filter -A OUTPUT -p tcp --dport 22 -j ACCEPT

########################################################################
## DNS
########################################################################
 iptables -t filter -A OUTPUT -p tcp --dport 53 -j ACCEPT
 iptables -t filter -A OUTPUT -p udp --dport 53 -j ACCEPT
 #iptables -t filter -A INPUT -p tcp --dport 53 -j ACCEPT
 #iptables -t filter -A INPUT -p udp --dport 53 -j ACCEPT

########################################################################
## NTP sortant
########################################################################
 iptables -t filter -A OUTPUT -p udp --dport 123 -j ACCEPT

########################################################################
## HTTP
########################################################################
 iptables -t filter -A INPUT -p tcp --dport 80 -j ACCEPT
 iptables -t filter -A INPUT -p tcp --dport 443 -j ACCEPT

 iptables -t filter -A OUTPUT -p tcp --dport 80 -j ACCEPT
 iptables -t filter -A OUTPUT -p tcp --dport 443 -j ACCEPT

########################################################################
## FTP sortant
########################################################################
 iptables -t filter -A OUTPUT -p tcp --dport 21 -j ACCEPT

 ## input FTP 
 #modprobe ip_conntrack_ftp
 #modprobe ip_nat_ftp
 #iptables -t filter -A INPUT -p tcp --dport 21 -j ACCEPT
 #iptables -t filter -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT


########################################################################
## Mail SMTP:25
########################################################################
 #iptables -t filter -A INPUT -p tcp --dport 25 -j ACCEPT
 #iptables -t filter -A OUTPUT -p tcp --dport 25 -j ACCEPT

########################################################################
## Mail POP3:110
########################################################################
 #iptables -t filter -A INPUT -p tcp --dport 110 -j ACCEPT
 #iptables -t filter -A OUTPUT -p tcp --dport 110 -j ACCEPT

########################################################################
## Mail IMAP:143
########################################################################
 #iptables -t filter -A INPUT -p tcp --dport 143 -j ACCEPT
 #iptables -t filter -A OUTPUT -p tcp --dport 143 -j ACCEPT

########################################################################
## Mail POP3S:995
########################################################################
 #iptables -t filter -A INPUT -p tcp --dport 995 -j ACCEPT
 #iptables -t filter -A OUTPUT -p tcp --dport 995 -j ACCEPT

########################################################################
## Team Speak 3
########################################################################

 ## Listen socket
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

 ########################################################################
 ## openvpn
 ########################################################################

 ## vpn use udp or tcp not all ! (USE UDP)
 #iptables -I INPUT -p udp --dport 1194 -j ACCEPT
 ## or
 #iptables -I INPUT -p tcp --dport 1194 -j ACCEPT

 ## Tun mode (USE)
 #iptables -I INPUT -i tun0 -j ACCEPT
 #iptables -I FORWARD -i tun0 -j ACCEPT
 #iptables -I FORWARD -o tun0 -j ACCEPT
 #iptables -I OUTPUT -o tun0 -j ACCEPT

 ## Bridge mode (NOT USE)
 #iptables -I INPUT -i tap0 -j ACCEPT
 #iptables -I FORWARD -i tap0 -j ACCEPT
 #iptables -I FORWARD -o tap0 -j ACCEPT
 #iptables -I OUTPUT -o tap0 -j ACCEPT
 #iptables -I INPUT -i br0 -j ACCEPT
 #iptables -I FORWARD -i br0 -j ACCEPT
 #iptables -I OUTPUT -o br0 -j ACCEPT

########################################################################
## After all personnal rules finish init to drop w00tbot
########################################################################

 # chaîne w00t :
 # recherche du premier SYN et création de la liste :
 iptables -A w00t -m recent -p tcp --syn --dport 80 --set

 # recherche du paquet SYN,ACK et mise à jour la liste :
 iptables -A w00t -m recent -p tcp --tcp-flags PSH,SYN,ACK SYN,ACK --sport 80 --update

 # recherche du paquet ACK et mise à jour la liste :
 iptables -A w00t -m recent -p tcp --tcp-flags PSH,SYN,ACK ACK --dport 80 --update

 # recherche de la signature hexadécimale dans le prenier PSH+ACK.
 # Si elle est présente, on renvoie sur w00tchain pour blacklister et
 # terminer la connexion.
 # On supprime la liste pour ne pas filtrer les paquets suivants :
 iptables -A w00t -m recent -p tcp --tcp-flags PSH,ACK PSH,ACK --dport 80 --remove \
     -m string --to 80 --algo bm --hex-string '|485454502f312e310d0a0d0a|' -j w00tchain

########################################################################
## End of rules update, restart fail2ban
########################################################################
 /etc/init.d/fail2ban start
 echo Setting firewall rules finish !
