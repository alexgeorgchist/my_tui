#!/system/bin/sh
# sysinfo - Prints system information with ascii art logo
# By: DeadRabbit
# Telegram: @deadrabbit404

PROGNAME=${0##*/}
LOGODIR="/sdcard/t-ui/logos"
LOGO="android_sanyo"
BRAND=`getprop ro.product.brand`
MODEL=`getprop ro.product.model`
CODENAME=`getprop ro.product.device`
ANDROID_VERSION=`getprop ro.build.version.release`
CPUARCH=`getprop ro.product.cpu.abi`
CPUCORE=`grep -c "^processor" /proc/cpuinfo`
CPUFREQ=`< /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq`
MEMTOTAL=`grep MemTotal /proc/meminfo | awk '{ print $2 }'`
MEMAVAIL=`grep MemAvail /proc/meminfo | awk '{ print $2 }'`
MEMPERC=$(awk "BEGIN {print ($MEMAVAIL/$MEMTOTAL)*100}")
MEMPERCROUND=$(echo $MEMPERC | awk '{printf("%.2f \n",$1)}') # krugl posle zapatoy
ZRAM=`grep SwapTotal /proc/meminfo | awk '{ print $2 }'`
KERNEL=`uname -r | cut -f 1 -d "/"`
PATCH=`getprop ro.build.version.security_patch`
DATA_ENCRYPTION=`getprop ro.crypto.state`
COORD=" [%lat, %lon]"

# Truncate those having 0 values from output of `uptime -p`
UPTIME=`uptime -p | sed "s/ 0 [^ ]*,//g" | sed "s/up //"`

# Determine SELinux status without root access
cat /sys/fs/selinux/enforce >/dev/null 2>&1
[ $? -eq 0 ] && SELINUX="Permissive" || SELINUX="Enforcing"



print_distro_logo () {
# Print distro ascii art logo
    cat "$LOGODIR/$LOGO"
}


get_public_ip () {
    ip=`curl -s ifconfig.me`
    ip=${ip:="<Unkown>"}
    echo "$ip"
    exit 0
}


print_sysinfo () {
# Print all the information
    padding=15
    printf "%${padding}s : %s\n"\
        "Phone Model" "$BRAND $MODEL"\
        "Codename" "$CODENAME"\
        "OS Type" "Android $ANDROID_VERSION ($CPUARCH)"\
        "Security Patch" "$PATCH"\
        "/data Status" "$DATA_ENCRYPTION"\
        "SELinux" "$SELINUX"\
        "CPU" "$CPUCORE core(s) @ $((CPUFREQ/1000))MHz"\
        "Memory" "$((MEMAVAIL/1024))MiB / $((MEMTOTAL/1024))MiB  $MEMPERCROUND%"\
        "zRAM Size" "$((ZRAM/1024))MiB"\
        "Kernel" "$KERNEL"\
        "Uptime" "$UPTIME"
        printf "%${padding}s : %s\n" "Public IPv4" `get_public_ip`

    printf " \n"
    exit 0
}



# Script starts here
 
print_distro_logo
print_sysinfo






