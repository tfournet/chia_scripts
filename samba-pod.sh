firewall-cmd --add-service --permanent samba
firewall-cmd --add-service samba

container_name="sambaPlots"

podman run --name ${container_name} -p 139:139 -p 445:445 -p 137:137/udp -p 138:138/udp -v "/plots:/plots:Z" \
    -e USERID=1002 -e GROUPID=64003 -d dperson/samba -n -s "plots;/plots;yes;yes;yes;all;none;none;plots" \
    -p -g "usershare allow guests = yes" -g "map to guest = tfournet" -g "load printers = no" -g "printcap cache time = 0" -g "printing = bsd" -g "printcap name = /dev/null" -g "disable spoolss = yes"

service="container-${container_name}"
service_file="/etc/systemd/system/${service}.service"
podman generate systemd --name "${container_name}" >"${service_file}"
systemctl enable ${service}
systemctl start ${service}