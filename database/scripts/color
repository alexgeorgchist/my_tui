#!/bin/sh

SCRIPTNAME=${0##*/}

tui="/storage/emulated/0/t-ui"
logos="/storage/emulated/0/t-ui/logos"
################################
#
#  <apps_bg_color value="yellow"/>
#  <alias_text_color value="yellow">
#  <input_color value="yellow"/>
#  <status_lines_bgrectcolor value="#00000000,yellow,#00000000,#00000000,#00000000,#00000000,#00000000,#00000000,#00000000"/>
#  <input_bgrectcolor value="yellow"/>
#
################################

print_header () {
cat $logos/android_sanyo
}

print_end () {
printf "   %-7s%s\n"\
          " " "Тема $new установлена"\
          " " "    Restart"
exit 0
}

show_help () {
printf "   %-10s%s\n"\
           " " "Для установки набрать"\
           " " "color и цифру:"\
           " " " "
printf "   %-16s%-16s%-16s\n"\
           "1. Golden" "4. Silver" "7. AndroidGreen"\
           "2. AirForceBlue" "5. Pistachio" "8. Olive"\
           "3. Ecru" "6. Tomato" "9. Teal"\
           " " " " " "\
           "Примеры:" "'color 3' " " "
}

change () {
cd $tui
sed -i "38s/20/ff/" theme.xml #look 53str
touch abv.txt
sed '8!d' suggestions.xml | tee abv.txt
old=$(sed -e 's/<apps_bg_color value="//; s/"\/>//' abv.txt)
sed -i "8s/${old}/${new}/" suggestions.xml
sed -i "9s/${old}/${new}/" suggestions.xml
sed -i "3s/${old}/${new}/" theme.xml
sed -i "33s/${old}/${new}/" theme.xml
sed -i "34s/${old}/${new}/" theme.xml
sed -i "38s/${old}/${new}/" theme.xml
sed -i "38s/ff/20/" theme.xml
rm -rf abv.txt
}

case "$1" in
    1|g)
		new="#ffffd700"
        change
        ;;
    2|afb)
        new="#ff5d8aa8"
        change
        ;;
    3|e)
        new="#ffc2b280"
        change
        ;;
    4|s)
        new="#ffc0c0c0"
        change
        ;;
    5|p)
        new="#ff93c572"
        change
        ;;
    6|t)
        new="#ffff6347"
        change
        ;;
    7|ag)
        new="#ffa4c639"
        change
        ;;
    8|o)
        new="#ff808000"
        change
        ;;
    9|t)
        new="#ff008080"
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




