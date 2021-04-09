#!/bin/bash
### BEGIN INIT INFO
# Provides:          adbd
# Required-Start:
# Required-Stop:
# Default-Start: S
# Default-Stop: 6
# Short-Description:
# Description:       Linux ADB
### END INIT INFO

# setup configfs for adbd

ADB_EN=on

case "$1" in
start)
    if [ $ADB_EN = on ];then
        if [ ! -e "/dev/usb-ffs/adb" ] ; then
        modprobe g_ffs idVendor=0x18d1 idProduct=0x4e42 iSerialNumber="buildroot"
            mkdir -p /dev/usb-ffs/adb
            mount -o uid=2000,gid=2000 -t functionfs adb /dev/usb-ffs/adb
        fi
        export service_adb_tcp_port=5555
        #start-stop-daemon --start --oknodo --pidfile /var/run/adbd.pid --startas /usr/local/bin/adbd --background
        start-stop-daemon --start --oknodo --pidfile /var/run/adbd.pid --startas /data/adbd/adbd --background
        sleep 1
    fi
    ;;
stop)
    if [ $ADB_EN = on ];then
        #start-stop-daemon --stop --oknodo --pidfile /var/run/adbd.pid --retry 5
        pkill -f adbd
    fi
    ;;
restart|reload)
    ;;
*)
    echo "Usage: $0 {start|stop|restart}"
    exit 1
esac

exit 0
