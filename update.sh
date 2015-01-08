new_iptables=/tmp/new_iptables
current_iptables=/etc/iptables.d/61-redsocks
node gen_iptables.js
if [ $? -eq 0 ]; then
    diff $new_iptables $current_iptables
    if [ ! $? -eq 0 ]; then
        mv $new_iptables $current_iptables
        chmod +x $current_iptables
        /etc/init.d/gociptables restart
        /sbin/iptables -L -t nat
    fi
else
    echo "failed!"
    #TODO - send gocalert
fi
