#!/bin/sh

## MM - My Manager
## Author  	: AGCH
## Github  	: @alexgeorgchist

##################################
##                              ##
##       ##   ##  ##   ##       ##
##   #   ### ###  ### ###   #   ##
##  ###  ## # ##  ## # ##  ###  ##
##   #   ##   ##  ##   ##   #   ##
##       ##   ##  ##   ##       ##
##                              ##
##################################

SCRIPTNAME=${0##*/}

home="/storage/emulated/0"
link="https://raw.githubusercontent.com/alexgeorgchist/my_tui/main/database"

line1="============================================="
line2="---------------------------------------------"
ERROR="Что-то не то, надо разобраться"
padding=23


print_head() {
    printf " %s\n" \
              "$line1" \
              "• Привет, Сашечка." \
              "• Программа $SCRIPTNAME обновит ( восстановит ) скрипт mm.sh" \
              "$line2"
    sleep 1.5
}

givme_mm_scriptman() {       
cd $home
if [ -f $home/mm.sh ]; then rm -rf mm.sh
    block1 && block2
else block2
fi
}

block1() {
    printf " %${padding}s %s\n" \
              "Заменяемые файлы удалены" "           ▁ ▂ ▃ ▄ 32% "
}

block2() {
    sleep 0.5
    printf " %${padding}s %s\n" \
              " " " " \
              "Загружаю               " "      ▁ ▂ ▃ ▄ ▅ ▆ 68%"
    sleep 0.5
cd $home
curl -LJO -s $link/mm.sh

    printf " %${padding}s %s\n" \
              " " " "\
              "Обновление загружено"  "    ▁ ▂ ▃ ▄ ▅ ▆ ▇ █ 100%" \
              " "
    sleep 0.5
}              



goto_mm() {                           
if [ $? = 0 ] && [ -f $home/mm.sh ]
    then  sh ./mm.sh -v
        if [ $? = 77 ] # look in the mm.sh script version exit 77
            then printf " %s\n\n" $line1
                sleep 1.0 && sh ./mm.sh -h
                  if [ $? = 55 ] # look in the mm.sh script version exit 66
                     then sleep 1.0 && sh ./mm.sh -l
                     else printf " %s\n" $ERROR
                 fi
        fi
fi
}


print_end() {
if [ $? != 66 ] # look in the mm.sh script show_help exit 55
    then printf " %s\n" $ERROR
    else printf " %s\n" " Сашечка, $SCRIPTNAME завершил программу"
    exit 0
fi
}

print_head
givme_mm_scriptman
goto_mm
print_end
