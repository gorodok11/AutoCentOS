

## Flush rules & reset counters
iptables -F
iptables -Z

# Accept ftp-data and ftp (ports 20 & 21)
iptables -A INPUT -p tcp -m tcp --syn --dport 20 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --syn --dport 21 -j ACCEPT

# Accept ssh (port 22)
iptables -A INPUT -p tcp -m tcp --syn --dport 22 -j ACCEPT

# Accept telnet (port 23)
#iptables -A INPUT -p tcp -m tcp --syn --dport 23 -j ACCEPT

## Accept smtp (port 25)
iptables -A INPUT -p tcp -m tcp --syn --dport 25 -j ACCEPT

## Accept dns (port 53)
iptables -A INPUT -p udp -m udp -s 0/0 --dport 53 -d 0/0 -j ACCEPT
iptables -A INPUT -p tcp -m tcp -s 0/0 --dport 53 -d 0/0 -j ACCEPT

## Accept http (port 80 and alternative 8080)
iptables -A INPUT -p tcp -m tcp --syn --dport 80 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --syn --dport 8080 -j ACCEPT
#iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT

# Accept pop3 (port 110)
iptables -A INPUT -p tcp -m tcp --syn --dport 110 -j ACCEPT

# Accept inbound identd (port 113)
iptables -A INPUT -p tcp -m tcp --syn --dport 113 -j ACCEPT
# or you can reject and send back a TCP RST packet instead
#iptables -A INPUT -p tcp -m tcp --dport 113 -j REJECT --reject-with tcp-reset

# Accept imap (port 143)
iptables -A INPUT -p tcp -m tcp --syn --dport 143 -j ACCEPT

# Accept https (port 443)
iptables -A INPUT -p tcp -m tcp --syn --dport 443 -j ACCEPT

# Accept smtps (port 465)
iptables -A INPUT -p tcp -m tcp --syn --dport 465 -j ACCEPT

# Accept msp (port 587)
iptables -A INPUT -p tcp -m tcp --syn --dport 587 -j ACCEPT

# Accept imaps (port 993)
iptables -A INPUT -p tcp -m tcp --syn --dport 993 -j ACCEPT

# Accept pop3s (port 995)
iptables -A INPUT -p tcp -m tcp --syn --dport 995 -j ACCEPT

# Drop outside initiated connections
iptables -A INPUT -m state --state NEW -j REJECT

# Allow all outbound tcp, udp, icmp traffic with state
iptables -A OUTPUT -p tcp -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p udp -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p icmp -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

# Save rules
service iptables save

echo "iptables configuration is complete."
echo ""
echo "Check your rules - iptables -L -n"
echo ""

