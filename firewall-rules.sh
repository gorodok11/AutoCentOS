

#Append rule to open port 80 HTTP
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT
#Append rule to open port 8080 HTTPS
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 8080 -j ACCEPT
