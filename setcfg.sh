#! /bin/bash
#description: this is a auto script, create laplat's camera project and config 5.8G wifi for client
#author: 461911662
#date: 2019/06/26

mkdir -p /root/laplat_camera/exec_bin

nmcli con delete "quluxllbaobao"
nmcli dev wifi hotspot ifname wlan0 con-name "quluxllbaobao" ssid "My_wifi" band a channel 165 password "11111111"
nmcli connection modify "quluxllbaobao" connection.autoconnect yes
nmcli con mod "quluxllbaobao" ipv4.method shared ipv4.addr "192.168.100.1/27"
nmcli con mod "quluxllbaobao" ipv4.gateway 192.168.100.1

cat << EOF > /root/laplat_camera/exec_bin/setwlan.sh
#! /bin/bash

/etc/init.d/network-manager restart

sleep 10
/root/laplat_camera/exec_bin/demosimplest &
EOF
chmod a+x /root/laplat_camera/exec_bin/setwlan.sh

grep "/root/laplat_camera/exec_bin/setwlan.sh" -Rn /etc/rc.local || sed -i "s#exit 0#\n/root/laplat_camera/exec_bin/setwlan.sh\n\nexit 0\n#g" /etc/rc.local

reboot

