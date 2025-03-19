#!/bin/sh

## SM - Script Manager
## Github  	: @alexgeorgchist

SCRIPTNAME=${0##*/}

# Enter data for a new release
VER="v.1.03"
DATERELEASE="18.03.25"

##DIRECTORIES
TUI="/storage/emulated/0/t-ui"
SCRIPTDIR="/storage/emulated/0/t-ui/script"

##OTHERS
line1="============================================="
line2="----------------------------------------------"
padding1=-22
padding2=-18
padding3=-7
padding4=-9
padding5=-40

## LINK
linkdir="https://github.com/alexgeorgchist/my_tui/raw/main/database/scripts"

## GET SCRIPT LIST
scriptlist=(6p.sh chwf.sh color.sh info.sh pogoda.sh pokoypsaltir.sh sysinfo.sh top_custom_info.sh town-loc.sh) # Massiv tem
LIMIT=${#scriptlist[@]} #Number of topics in the array list



sm_logo () {
    echo $line1
    printf "%s%s\n" \
              "" "•~• SCRIPTMAN •~• SCRIPTMAN •~• SCRIPTMAN •~•" \
              " " " "
    printf "%${padding3}s%s\n" \
              " " "############    ####      ####" \
              " " "####            #### #  # ####" \
              " " "############    ####  ##  ####" \
              " " "        ####    ####      ####" \
              " " "############    ####      ####" \
              " " " "
    printf "%${padding4}s%s\n" \
              " " "Менеджер загрузок скриптов"
    echo; echo
}


print_end () {
    printf " \n"
    printf "%s\n" \
              "$line1"\
              " " \
              "           Перезагрузите «T-UI» " \
              " " \
              "$line1"    
    printf " \n\n"
    exit 0    
}


show_help() {   
sm_logo
	printf "%s\n" $line2
	printf " %${padding2}s%s\n" \
	          ":.: Как пользоваться:" " "\
      	    " " " "\
              "[-h, --help]" "[1,2 или 3... до $LIMIT]"\
              "[-l, --list]" "[-v, --version]" \
              " "
    printf " %${padding2}s%s\n" \
      	    "от 1 до $LIMIT" "    => Установка скрипта" \
              "-l, --list" "=> Показать доступные скрипты" \
              "-h, --help" "=> Справка по использованию" \
              "-v, --version" "=> Версия программы" \
              " "     
	printf "%s\n" $line2
    printf " %${padding2}s%s\n" \
              ":.: Примечание: " "  Набрать $SCRIPTNAME," \
              " " "далее выбранный" \
              " " "аттрибут через пробел."
    printf "%s\n" $line2 
    exit 0      
}


show_script() {
sm_logo
	printf " \n"
	printf "%s\n" \
               "     My Script Loader $VER от $DATERELEASE" \
	           "$line2"\
               "         СПИСОК ДОСТУПНЫХ СКРИПТОВ:         "

VAR=1 # Number of topics in the array list LIMIT=${#THEME_LIST[@]}
    while [ "$VAR" -le "$LIMIT" ] # <=
    do
    echo "   $VAR. ${scriptlist[$VAR-1]}"
VAR=`expr $VAR + 1` # Allowed VAR=$(($VAR+1)) or let "VAR += 1"
    done
    	printf "%s\n" \
	              "$line2"
    	printf " %s\n " \
          		" :.: Для установки набрать: $SCRIPTNAME номер" \
          		"    Пример: $SCRIPTNAME 2 [ загрузка chwf ] " \
          	    " " \
          		":.: $SCRIPTNAME -h    -- вызов справки"	
    exit 0
}


version() {
sm_logo
	printf " %s\n" \
	          " " \
              ":.: $SCRIPTNAME - My Script Loader ( scripts for t-ui )" \
	          ":.: Версия программы  $VER от $DATERELEASE "	
	exit 0
}


load_chosen_script() {
cd $TUI
    if [[ ! -d script ]]
    then mkdir /storage/emulated/0/t-ui/script
    fi
cd $SCRIPTDIR
    curl -LJO -s $linkdir/$CHOSEN_SCRIPT
    echo "$CHOSEN_SCRIPT =sh /storage/emulated/0/t-ui/script/$CHOSEN_SCRIPT %">>$TUI/alias.txt
        printf "%${padding5}s%s\n" \
                  "Скрипт $CHOSEN_SCRIPT ==>" "- успешно" \
                  "Alias ссылка" "- добавлена" \
                  " " " "
 #       echo $arg $CHOSEN_SCRIPT
##        echo "     - загрузка --> успешно" || echo "     - ошибка загрузки"
# Alias update
#        echo "$CHOSEN_SCRIPT =sh /storage/emulated/0/t-ui/script/$CHOSEN_SCRIPT %">>$TUI/alias.txt
#        echo "     - ссылка $CHOSEN_SCRIPT в файл alias --> добавлена" || echo "     - ошибка вставки ссылки alias $CHOSEN_SCRIPT"
}



#### INPUT FILTER
for arg in $@
do
    case $arg in
        -h|--help)
            show_help
            ;;
        -v|--ver)
            version
            ;;
        -l|--list)
        show_script
            ;;
#        [1-$LIMIT])
#            ATTRNUM_ARRAY+=($arg)
#           echo ${scriptlist[$arg-1]}
#            load_chosen_script
#            ;;         
            1)
                CHOSEN_SCRIPT="${scriptlist[0]}"
                load_chosen_script
                ;;
            2)
                CHOSEN_SCRIPT="${scriptlist[1]}"
                load_chosen_script
                ;;
            3)
                CHOSEN_SCRIPT="${scriptlist[2]}"
                load_chosen_script
                ;;
            4)
                CHOSEN_SCRIPT="${scriptlist[3]}"
                load_chosen_script
                ;;
            5)
                CHOSEN_SCRIPT="${scriptlist[4]}"
                load_chosen_script
                ;;
            6)
                CHOSEN_SCRIPT="${scriptlist[5]}"
                load_chosen_script
                ;;
            7)
                CHOSEN_SCRIPT="${scriptlist[6]}"
                load_chosen_script
                ;;
            8)
                CHOSEN_SCRIPT="${scriptlist[7]}"
                load_chosen_script
                ;;
            9)
                CHOSEN_SCRIPT="${scriptlist[8]}"
                load_chosen_script
                ;;
            *)
                echo $line1
                echo "Недействительный атрибут"
                sleep 1.0
                show_script 
    esac
done

print_end
