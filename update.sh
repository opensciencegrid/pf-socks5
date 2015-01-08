new_iptables=/tmp/new_iptables
current_iptables=/etc/iptables.d/61-redsocks
node gen_iptables.js $new_iptables
if [ $? -eq 0 ]; then
    diff $new_iptables $current_iptables
else
    echo "failed!"
    #TODO - send gocalert
fi
