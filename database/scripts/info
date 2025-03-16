#!/system/bin/sh
## Author  	: AGCH
## Github  	: @alexgeorgchist
## 26.01.2023
## Thanks to @deadrabbit404

PROGNAME=${0##*/}
LOGODIR="/sdcard/t-ui/ascii"
LOGO="inf.txt"
TUI="/storage/emulated/0/t-ui"


#BRAND=`getprop ro.product.brand`
#MODEL=`getprop ro.product.model`
#CODENAME=`getprop ro.product.device`
#ANDROID_VERSION=`getprop ro.build.version.release`
#CPUARCH=`getprop ro.product.cpu.abi`
#CPUCORE=`grep -c "^processor" /proc/cpuinfo`
#CPUFREQ=`< /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq`
MEMTOTAL=`grep MemTotal /proc/meminfo | awk '{ print $2 }'`
MEMAVAIL=`grep MemAvail /proc/meminfo | awk '{ print $2 }'`
MEMPERC=$(awk "BEGIN {print ($MEMAVAIL/$MEMTOTAL)*100}")
MEMPERCROUND=$(echo $MEMPERC | awk '{printf("%.2f \n",$1)}') # krugl posle zapatoy
#ZRAM=`grep SwapTotal /proc/meminfo | awk '{ print $2 }'`
#KERNEL=`uname -r | cut -f 1 -d "/"`
#PATCH=`getprop ro.build.version.security_patch`
#DATA_ENCRYPTION=`getprop ro.crypto.state`

# Truncate those having 0 values from output of `uptime -p`
UPTIME=`uptime -p | sed "s/ 0 [^ ]*,//g" | sed "s/up //" | sed "s/week/нед/" | sed "s/days/д/" | sed "s/day/д/" | sed "s/hours/ч/" | sed "s/minutes/мин/"`
# The time has been up
BEENTIMEUP=`uptime -s`


#Read psalms for everydays
everyday_psalm () {
DIR="/storage/emulated/0//t-ui/script_texts"
TXT1="$DIR/numdate.txt"
TXT2="$DIR/numpsalm.txt"
NOWTIME=`date +%j` #Number day of the year (001-365)
if [[ ! -f $TXT1 ]] || [[ ! -f $TXT2 ]]
    then echo " !!! Надо вписать номер сегодняшней кафизмы в numpsalm.txt в папке script_texts"
             echo $NOWTIME > $DIR/numdate.txt
             echo 1 > $DIR/numpsalm.txt
             exit 0
fi
LASTTIME=`cat $DIR/numdate.txt`
    let "RAZN = $NOWTIME - $LASTTIME"

LASTPSALM=`cat $DIR/numpsalm.txt`
    let "PSALM = $LASTPSALM + $RAZN"

if [ "$PSALM" -gt 20 ] # >20
    then let "PSALM = $PSALM - 20"
fi

echo $NOWTIME > $DIR/numdate.txt
echo $PSALM > $DIR/numpsalm.txt

    padding=16
    printf "   %-${padding}s : %-s\n"\
              " " " "\
              "Today" "$PSALM кафисма"
}

sorokoust () {
D=`date +%j`
let "DD = $D - 126" # Set 126 or another for a first day
N="Valentina"

padding=16
if [ "$DD" -ge 1 ] && [ "$DD" -le 40 ] # >=1 & <=40
    then printf "   %-${padding}s : %-s\n"\
                       " " " " \
                       "$N" "$DD" # Set name
    else printf "   %-${padding}s : %-s\n"\
                        "Sorokoust" "noname"
fi
}

# !!! Read Psaltir
psaltir_papa_mama () {

DATENOW=`date +%j` #Number day of the year xxx-format

# Papa
BEGINDAYPAPA=60      # Day of the begin to read psaltir papa=66!!! because before STRASNAYA
let "PKRUG1 = $BEGINDAYPAPA + 20"
let "PKRUG2 = $BEGINDAYPAPA +40"
let "P = $DATENOW - $BEGINDAYPAPA"
PREAD="$P"  # which days from the begin to read

if [ "$DATENOW" -ge "$BEGINDAYPAPA" ] && [ "$DATENOW" -lt "$PKRUG1" ] # >=60 &&<80
     then let "PREAD = $P + 1"
         elif [ "$DATENOW" -ge "$PKRUG1" ] && [ "$DATENOW" -lt "$PKRUG2" ] # >=80 && <100
             then let "PREAD = $P - 19" # $P + 1 - 20
                 elif [ "$DATENOW" -ge "PKRUG2" ]
                     then let "X = $DATENOW - 365" && let "PREAD = $X - $BEGINDAYPAPA"
                         elif [ "$P" -eq -1 ] # = -1
                             then PREAD="zavtra"
fi
     
#Mama
BEGINDAYMAMA=116 # Day of the begin to read psaltir mama=116
let "MKRUG1 = $BEGINDAYMAMA + 20"
let "MKRUG2 = $BEGINDAYMAMA +40"
let "M = $DATENOW - $BEGINDAYMAMA"
MREAD="$M" # which days from the begin to read

if [ "$DATENOW" -ge "$BEGINDAYMAMA" ] && [ "$DATENOW" -lt "$MKRUG1" ] # >=116 && <136
     then let "MREAD = $M + 1"
         elif [ "$DATENOW" -ge "$MKRUG1" ] && [ "$DATENOW" -lt "$MKRUG2" ] # >=136 && <156
             then let "MREAD = $M - 19" # $P + 1 - 20
                 elif [ "$DATENOW" -ge "$MKRUG2" ] # >=156
                     then let "X = $DATENOW - 365" && let "MREAD = $X - $BEGINDAYMAMA"
                         elif [ "$M" -eq -1 ] # = -1
                             then MREAD="zavtra"
fi

padding=16

PREAD=`echo $PREAD | sed "s/-//"`
MREAD=`echo $MREAD | sed "s/-//"`

printf "   %-${padding}s : %-s\n"\
          "Papa psalms" "$PREAD"\
          "Mama psalms" "$MREAD"
                 
if [ "$PREAD" -ge 1 ] && [ "$PREAD" -le 20 ]
   then sleep 2 && sh /storage/emulated/0/t-ui/script/pokoypsaltir %
       elif  [ "$MREAD" -ge 1 ] && [ "$MREAD" -le 20 ]   
           then sleep 2 && sh /storage/emulated/0/t-ui/script/pokoypsaltir %
             else everyday_psalm
              fi
}


# Determine SELinux status without root access
cat /sys/fs/selinux/enforce >/dev/null 2>&1
[ $? -eq 0 ] && SELINUX="Permissive" || SELINUX="Enforcing"


print_duble_line () {
    printf " =============================================="
    printf " \n"
}
    
print_logo () {
# Print distro ascii art logo
    cat "$LOGODIR/$LOGO"
}


get_public_ip () {
    ip=`curl -s ifconfig.me`
    ip=${ip:="<Unkown>"}
    echo "$ip"
    exit 0
}


print_info () {
# Print all the information
    padding=16
    printf "   %-${padding}s : %-s\n"\
        "Available" "$((MEMAVAIL/1024)) MiB  $MEMPERCROUND%"\
        "Total" "$((MEMTOTAL/1024)) MiB"\
        "Up time" "$BEENTIMEUP"\
        " " "$UPTIME"
#        printf "%${padding}s : %s\n" "Public IPv4" `get_public_ip`
}

notes () {
cd $TUI
abc=notefile.txt
    
if [ ! -z "$( cat ${abc} )" ]  # if file is not empty
then
printf "%-4s%-24s\n"\
           " " " "\
           " " "•°•.•°•.•°•.•°• Список дел •°•.•°•.•°•.•°•"\
           " " " "
             x=1
while IFS= read -r string; do
    if [ "$x" -le 9 ]; then    
printf "%-1s %-30s\n"\
           " " " $x. $string"
    else
printf "%-1s %-30s\n"\
           " " " $x. $string"
    fi
           let "x = $x + 1"
done < notefile.txt
fi
}

pings () {
ping -c2 google.com
}

# Script starts here

print_duble_line
print_logo
print_info
#sorokoust
#psaltir_papa_mama
#notes
print_duble_line
pings
print_duble_line







