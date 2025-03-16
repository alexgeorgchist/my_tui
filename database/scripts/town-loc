#!/bin/sh

SCRIPTNAME=${0##*/}

tui="/storage/emulated/0/t-ui"
logos="/storage/emulated/0/t-ui/logos"

################################
# TOWNS COORD
kazan="55.79,49.22"
sanktpeterburg="59.92,30.39"
svetlogorsk="54.94,20.15"
moskva="55.76,37.62"
kislovodsk="43.90,42.74"
################################

print_header () {
cat $logos/android_sanyo
}

print_end () {
printf "   %-7s%s\n"\
          " " "Координаты заменены"\
          " " "    Restart"
exit 0
}

show_help () {
printf "   %-10s%s\n"\
           " " "Для установки координат набрать"\
           " " "town и цифру:"\
           " " " "
printf "   %-16s\n"\
           "1. Казань"\
           "2. Санкт Петербург"\
           "3. Светлогорск"\
           "4. Москва"\
           "5. Кисловодск"\
           " "\
           "Примеры: town 2"
}

change () {
cd $tui
touch town.txt
sed '34!d' behavior.xml | tee town.txt
old=$(sed -e 's/<weather_location value="//; s/"\/>//' town.txt)
sed -i "34s/${old}/${new}/" behavior.xml
#sed -i "9s/${old}/${new}/" suggestions.xml
#sed -i "3s/${old}/${new}/" theme.xml
#sed -i "33s/${old}/${new}/" theme.xml
#sed -i "34s/${old}/${new}/" theme.xml
#sed -i "38s/${old}/${new}/" theme.xml
#sed -i "38s/ff/20/" theme.xml
rm -rf town.txt
}

case "$1" in
    1)
		new=$kazan
        change
        ;;
    2)
        new=$sanktpeterburg
        change
        ;;
    3)
        new=$svetlogorsk
        change
        ;;
    4)
        new=$moskva
        change
        ;;
    5)
        new=$kislovodsk
        change
        ;;
     *)
        echo "==============================================="
        show_help
        echo "==============================================="
        exit 0
        ;;
esac

##
print_header
print_end




