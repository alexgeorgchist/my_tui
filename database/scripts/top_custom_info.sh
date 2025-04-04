#!/system/bin/sh

# By: DeadRabbit, Alex Chistyakov
# Telegram: @deadrabbit404, @alexgeorgchist

PROGNAME=${0##*/}

padding1=12
padding2=21
padding3=21
DIR="/storage/emulated/0//t-ui/script_texts"
TUI="/storage/emulated/0/t-ui"
TXT1="/storage/emulated/0//t-ui/script_texts/numdate.txt"
TXT2="/storage/emulated/0//t-ui/script_texts/numpsalm.txt"
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
#KERNEL=`uname -r | cut -f 1 -d "/"`
PATCH=`getprop ro.build.version.security_patch`
DATA_ENCRYPTION=`getprop ro.crypto.state`
IPSINET=$(ip -f inet addr show rmnet_data1 | grep "inet " | awk -F'[: ]+' '{ print $3 }')
IPSWLAN=$(ip -f inet addr show wlan0 | grep "inet " | awk -F'[: ]+' '{ print $3 }')
IPV4=`get_public_ip`

# Truncate those having 0 values from output of `uptime -p`
UPTIME=`uptime -p | sed "s/,//g" | awk '{ print $2,"нед",$4,"д",$6,"ч",$8,"мин" }'`
UPTIMEBEEN=`uptime -s`

# Determine SELinux status without root access
cat /sys/fs/selinux/enforce >/dev/null 2>&1
[ $? -eq 0 ] && SELINUX="Permissive" || SELINUX="Enforcing"


## TIME DATE YEAR
NOWTIME=`date +%j`           #Number day of the year (001-365)
DATA=`date +%d-%B`
GOD=`date +%Y`            
if [ $GOD -eq 2028 ]; then k=258; else k=257;fi
if [ $NOWTIME -ge $k ]; then GGGG=5509; else GGGG=5508;fi
let "ERA = $GOD + $GGGG"







notes () {
cd $TUI
    NOTEFILE=$(sed -e 's/<?xml version="1.0" encoding="UTF-8"?>//; s/<NOTES>//; s/<note creationTime="//; s/" value="//; s/" lock="false"\/>//; s/<\/NOTES>//; s/^.............//w notefile.txt' notes.xml)
    abc=notefile.txt
x=0
while IFS= read -r string; do
           let "x = $x + 1"
done < notefile.txt
    
if [ -z "$( cat ${abc} )" ]  # if file is empty (pustoy)
    then 
             BLOKNOT="✓ Нет записей."
             printf "  %-${padding1}s : %-${padding2}s %-${padding3}s\n"\
                        "NOTES:" "$BLOKNOT"
    else 
             BLOKNOT=" "
             continue      
x=1
printf "  %${padding1}s : %-${padding2}s %-${padding3}s\n"\
           "............" "...............:.: NOTES :.:..............."
while IFS= read -r string; do
printf "  %-${padding1}s : %-${padding2}s %-${padding3}s\n"\
           "Message $x." "$string"
           let "x = $x + 1"
done < notefile.txt
fi
}

print_telinfo () {
    printf "  %-${padding1}s : %-${padding2}s %${padding3}s\n"\
              "............" "..............:.: TELINFO :.:.............." " "\
              "Phone Model" "$BRAND M3 $MODEL" "$ERA  $DATA"\
              "Memory" "$((MEMAVAIL/1024)) Mib / $((MEMTOTAL/1024)) Mib" "FREE [$MEMPERCROUND%]"
}

print_sysinfo () {
printf "  %-${padding1}s : %-${padding2}s %-${padding3}s\n"\
              "............" "..............:.: SYSINFO :.:.............." " "\
              "Phone Model" "$BRAND $MODEL" " "\
        "CPU" "$CPUCORE core(s) @ $((CPUFREQ/1000))MHz" " "
}

get_public_ip () {
    ip=`curl -s ifconfig.me`
    ip=${ip:="<Unkown>"}
    printf "  %-${padding1}s : %-${padding2}s %${padding3}s\n"\
               "Public IPv4" "$ip" "$IPSWLAN"
}

print_uptime () {

    printf "  %-${padding1}s : %-${padding2}s %${padding3}s\n"\
              "............" "..............:.: SCRIPTS :.:.............." " "\
              "Uptime" "$UPTIMEBEEN" "$UPTIME"
}

#Read psalms for everydays
everyday_psalm () {
if [[ ! -f $TXT1 ]] || [[ ! -f $TXT2 ]]
    then echo " !!! Надо вписать номер сегодняшней кафизмы в numpsalm.txt в папке script_texts"
             echo $NOWTIME > $DIR/numdate.txt
             echo 1 > $DIR/numpsalm.txt
fi
LASTTIME=`cat $TXT1`
    let "RAZN = $NOWTIME - $LASTTIME"
LASTPSALM=`cat $TXT2`
    let "PSALM = $LASTPSALM + $RAZN"

if [ "$PSALM" -gt 20 ] # >20
    then let "PSALM = $PSALM - 20"
fi

echo $NOWTIME > $DIR/numdate.txt
echo $PSALM > $DIR/numpsalm.txt

    printf "  %-${padding1}s : %-${padding2}s%-${padding3}s\n"\
              "Today" "$PSALM kafisma" " "
}

# !!! Read Psaltir
psaltir_papa_mama_brat () {
DATENOW=`date +%j` #Number day of the year xxx-format
GOD=`date +%Y`

dp=(110 102 122 107) # день Пасхи 20апр2025 11апр2026 2мая2027 16апр2028
let "k = $GOD - 2025"
let "BEGINDAY = ${dp[$k]} - 48" # Пасха - 40 - страстная

let "KRUG1 = $BEGINDAY + 20"
let "KRUG2 = $BEGINDAY +40"
let "KRUG3 = $BEGINDAY +60"
let "KRUG4 = $BEGINDAY +80"
let "KRUG5 = $BEGINDAY +120"

let "READ = $DATENOW - $BEGINDAY"
if [ "$DATENOW" -ge "$BEGINDAY" ] && [ "$DATENOW" -lt "$KRUG1" ]
then let "READ = $READ + 1"; x=1
  elif [ "$DATENOW" -ge "$KRUG1" ] && [ "$DATENOW" -lt "$KRUG2" ] # >= && <
  then let "READ = $READ - 19"; x=2 #  + 1 - 20
    elif [ "$DATENOW" -ge "$KRUG2" ] && [ "$DATENOW" -lt "$KRUG3" ]
    then let "READ = $READ - 39"; x=3 #  + 1 - 40
      elif [ "$DATENOW" -ge "$KRUG3" ] && [ "$DATENOW" -lt "$KRUG4" ]
      then let "READ = $READ - 59"; x=4 #  + 1 - 60
        elif [ "$DATENOW" -ge "$KRUG4" ] && [ "$DATENOW" -lt "$KRUG5" ]
        then let "READ = $READ - 79"b x=5 #  + 1 - 80             
elif [ "$DATENOW" -ge "KRUG5" ]
then let "X = $DATENOW - 365" && let "READ = $X - $BEGINDAY"
  elif [ "$READ" -eq -1 ] # = -1
  then READ="zavtra"
fi

if [ "$DATENOW" -ge "$BEGINDAY" ] && [ "$DATENOW" -lt 156 ] || [ "$DATENOW" -ge 284 ] && [ "$DATENOW" -lt 324 ] # papa -40 i do 5 june; brat -40 i do 20 november
then READ=`echo $READ | sed "s/-//"` # delete minus in the number
printf "  %-${padding1}s : %-${padding2}s %${padding3}s\n"\
          "PapaMamaBrat" "$READ kafisma $x krug" "begin day $BEGINDAY $GOD" 
fi                 
}

sorokoust () {
FIRST=73 # Set the first day
NAME1="Lubov'"
SECOND=85 # Set the second day
NAME2="Anna"
NACHALO1="13.03.2024"
NACHALO2="25.03.2024"

let "DD1 = $NOWTIME - $FIRST + 1"
if [ "$DD1" -ge 1 ] && [ "$DD1" -le 40 ] # >=1 & <=40
    then printf "  %-${padding1}s : %-${padding2}s %-${padding3}s\n"\
                       "$NAME1" "$DD1 / 40" "c $NACHALO1" 
    else continue  
fi
let "DD2 = $NOWTIME - $SECOND +1"
if [ "$DD2" -ge 1 ] && [ "$DD2" -le 40 ] # >=1 & <=40
    then printf "  %-${padding1}s : %-${padding2}s %-${padding3}s\n"\
                       "$NAME2" "$DD2 / 40" "c $NACHALO2" 
    continue  
fi
}

top_skobka () {
printf "┏━━━━━━━━━━━━━┓­­­­­­­­­­ ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓­\n"
#printf "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓­­­­­­­­­­ ┏━━━━━━━━━━━━━━━━━━━━━━━━┓­­­­­­­­­­\n"
}
middle_skobka () {
printf  "  ••••••••••••   •••••••••••••••••••••••••••••••••••••••••••• \n"
}
bottom_skobka () {
printf "┗━━━━━━━━━━━━━┛ ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛\n"
#printf "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ ┗━━━━━━━━━━━━━━━━━━━━━━━━┛\n"
}


## Script menu##
top_skobka
print_telinfo
    echo
print_sysinfo
get_public_ip
#bottom_skobka
    echo
#top_skobka
print_uptime
psaltir_papa_mama_brat
# sorokoust
# everyday_psalm
    echo
notes
bottom_skobka








