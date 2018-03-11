#!/bin/sh
### BEGIN INIT INFO
# Provides:  iptables
# Required-Start:  $local_fs $network
# Required-Stop:  $local_fs $network
# Default-Start:  2 3 4 5
# Default-Stop:  0 1 6
# Short-Description: Firewall Rules for iptables
# Description: EDIT THIS FILE TO YOUR NEEDS BEFORE EXECUTING
### END INIT INFO#!/bin/sh
aptitude install iptables iptables-persistent fail2ban
service fail2ban stop
iptables -F
iptables -X
#DENY
iptables -N DENY
iptables -A DENY -p tcp -m tcp -m limit --limit 30/sec --limit-burst 100 -m comment --comment "Anti-DoS" -j REJECT --reject-with tcp-reset
iptables -A DENY -m limit --limit 30/sec --limit-burst 100 -m comment --comment "Anti-DoS" -j REJECT --reject-with icmp-proto-unreachable
iptables -A DENY -p tcp ! --syn -m state --state NEW -j DROP
iptables -A DENY -f -j DROP
iptables -A DENY -p tcp --tcp-flags ALL ALL -j DROP
iptables -A DENY -p tcp --tcp-flags ALL NONE -j DROP
iptables -A DENY -p icmp --icmp-type echo-request -m limit --limit 1/s -m comment --comment "Limit Ping Flood" -j ACCEPT
#iptables -A DENY -j LOG --log-prefix "PORT DENIED: " --log-level 5 --log-ip-options --log-tcp-options --log-tcp-sequence
iptables -A DENY -p tcp --tcp-flags ALL NONE -m limit --limit 1/h -m comment --comment "Anti-Portscan" -j ACCEPT
iptables -A DENY -p tcp --tcp-flags ALL ALL -m limit --limit 1/h -m comment --comment "Anti-Portscan2" -j ACCEPT
#Drop unusual flags
iptables -A DENY -p tcp --tcp-flags ALL FIN,URG,PSH -j DROP
iptables -A DENY -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j DROP
iptables -A DENY -p tcp --tcp-flags ALL NONE -j DROP
iptables -A DENY -p tcp --tcp-flags SYN,FIN SYN,FIN -j DROP
iptables -A DENY -p tcp --tcp-flags SYN,RST SYN,RST -j DROP
iptables -A DENY -m comment --comment "Ignore everything else" -j DROP
#BLOCKED
iptables -N BLOCKED
#ALLOWED
iptables -N ALLOWED
#iptables -A ALLOWED -s <YOUR IP HERE> -j ACCEPT ###EDIT AND UNCOMMENT THIS LINE!
#SERVICES
iptables -N SERVICES
iptables -A SERVICES -p tcp -m tcp --dport 53 -m comment --comment "Allow: DNS" -j ACCEPT
iptables -A SERVICES -p udp -m udp --dport 53 -m comment --comment "Allow: DNS" -j ACCEPT
iptables -A SERVICES -p tcp -m tcp --dport 22 -m comment --comment "Allow: SSH-Access" -j ACCEPT
iptables -A SERVICES -p tcp -m multiport --dports 80,8080,443 -m comment --comment "Allow: Webserver" -j ACCEPT
iptables -A SERVICES -j RETURN
#TEAMSPEAK
iptables -N TEAMSPEAK
#iptables -A TEAMSPEAK -p tcp -m tcp --dport 2008 -m comment --comment "Allow: TeamSpeak Accounting" -j ACCEPT
iptables -A TEAMSPEAK -p tcp -m tcp --dport 10011 -m comment --comment "Allow: TeamSpeak ServerQuery" -j ACCEPT
iptables -A TEAMSPEAK -p tcp -m multiport --dports 30033 -m comment --comment "Allow: TeamSpeak FileTransfer" -j ACCEPT
iptables -A TEAMSPEAK -p tcp -m tcp --dport 41144 -m comment --comment "Allow: TeamSpeak TSDNS" -j ACCEPT
iptables -A TEAMSPEAK -p udp -m udp --dport 1:65535 -m comment --comment "Allow: TeamSpeak Voiceports" -j ACCEPT
iptables -A TEAMSPEAK -j RETURN
#INPUT
iptables -A INPUT -m comment --comment "Allow Whitelisted IP's" -j ALLOWED
iptables -A INPUT -m comment --comment "Block Blacklisted IP's" -j BLOCKED
iptables -A INPUT -i lo -m comment --comment "Allow: Loopback" -j ACCEPT
iptables -A INPUT -m state --state RELATED,ESTABLISHED -m comment --comment "Allow: Related and Established Connections" -j ACCEPT
iptables -A INPUT -m comment --comment "Allow Default Services" -j SERVICES
iptables -A INPUT -m comment --comment "Allow TeamSpeak Services" -j TEAMSPEAK
iptables -A INPUT -p icmp -m comment --comment "Allow: ICMP" -j ACCEPT
iptables -A INPUT -m comment --comment "Ignore everything else" -j DENY
iptables -P INPUT DROP
/etc/init.d/iptables-persistent save
service fail2ban start
clear
iptables -L
If you want to easily add or remove entries from the ALLOWED/BLOCKED chain, you can use the following script, created by @Supervisor:
Code:
sudo nano firewall;sudo chmod +x firewall
Code:
#!/bin/sh
case $1 in
block*) iptables -I BLOCKED -s ${2} -j DROP ;;
unblock*) iptables -D BLOCKED -s ${2} -j DROP ;;
allow*) iptables -I ALLOWED -s ${2} -j ACCEPT ;;
disallow*) iptables -D ALLOWED -s ${2} -j ACCEPT ;;
*) printf "Usage: ./firewall 'block|unblock|allow|disallow' IP\n" ;;
esac
exit 1
