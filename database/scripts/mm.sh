#!/bin/sh

## MM - My Manager
## Author  	: AGCH ( thanks to EMA,Dedrabbit)
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

# Enter data for a new release
VER="v.7.01"
DATERELEASE="19.03.25"

##DIRECTORIES
HOME="/storage/emulated/0"
SCRIPTDIR="/storage/emulated/0/t-ui/script"
TUIDIR="/storage/emulated/0/t-ui"
ASCIIDIR="/storage/emulated/0/t-ui/ascii"
##OTHERS
TUI="t-ui"
ZP=".zip"
line1="============================================="
line2=----------------------------------------------
padding1=-22
padding2=-18
##
PERCENT1="                  ▋8%"
PERCENT2="                 ▋▋11%"
PERCENT3="                ▋▋▋15%"
PERCENT4="               ▋▋▋▋18%"
PERCENT5="              ▋▋▋▋▋26%"
PERCENT6="             ▋▋▋▋▋▋34%"
PERCENT7="            ▋▋▋▋▋▋▋45%"
PERCENT8="           ▋▋▋▋▋▋▋▋52%"
PERCENT9="          ▋▋▋▋▋▋▋▋▋60%"
PERCENT10="         ▋▋▋▋▋▋▋▋▋▋74%"
PERCENT11="        ▋▋▋▋▋▋▋▋▋▋▋88%"
PERCENT12="       ▋▋▋▋▋▋▋▋▋▋▋▋100%"

## LINK
LINK="https://github.com/alexgeorgchist/my_tui/raw/main/database/themes"
mmpiclink="https://raw.github.com/alexgeorgchist/my_tui//main/database/files_for_tui/mmpic.txt"
scriptlink="https://raw.github.com/alexgeorgchist/my_tui//main/database/scripts"

## GET THEME LIST
THEME_LIST=(aqua purplefon 2024 2025) # Massiv tem
LIMIT=${#THEME_LIST[@]} #Number of topics in the array list



print_header_mmpic() {
mmpic="$ASCIIDIR/mmpic.txt"
if [[ ! -f $mmpic ]]
    then
    cd $HOME
    curl -LJO -s $mmpiclink
    printf "%s \n"
    cat $HOME/mmpic.txt
    rm -rf $HOME/mmpic.txt
    else
    printf " \n"
    cat $ASCIIDIR/mmpic.txt
fi
}


print_end () {
    printf " \n"
    printf "%s\n" \
        "$line1"\
        "           $SCRIPTNAME - Тема «$CHOSEN_THEME»   "\
        "              успешно установлена.   " \
        " " \
        "              Перезагрузите «T-UI» " \
        " " \
        "$line1"    
    printf " \n\n"
    exit 0    
}


show_help() {    
	print_header_mmpic
	printf "%s\n" $line2
	printf " %${padding2}s%s\n" \
	    ":.: Как пользоваться:" " "\
	    " " " "\
        "[-h, --help]" "[1,2 или 3... до $LIMIT]"\
        "[-l, --list]" "[-v, --version]" \
        " "
    printf " %${padding2}s%s\n" \
	    "от 1 до $LIMIT" "    => Установка темы" \
        "-l, --list" "=> Показать доступные темы" \
        "-h, --help" "=> Справка по использованию" \
        "-v, --version" "=> Версия программы" \
        " "     
	printf "%s\n" $line2
    printf " %${padding2}s%s\n" \
              ":.: Примечание: " "  Набрать $SCRIPTNAME," \
              " " "далее выбранный" \
              " " "аттрибут через пробел."
    printf "%s\n" $line2       
	exit 55 # for mmload script	
}


show_theme() {
    print_header_mmpic
	printf " \n"
	printf "%s\n" \
               "     My Manager $VER от $DATERELEASE" \
	       "$line2"\
               "         СПИСОК ДОСТУПНЫХ ТЕМ:         "

VAR=1 # Number of topics in the array list LIMIT=${#THEME_LIST[@]}
while [ "$VAR" -le "$LIMIT" ] # <=
do
    echo "   $VAR. ${THEME_LIST[$VAR-1]}"
    VAR=`expr $VAR + 1` # Allowed VAR=$(($VAR+1)) or let "VAR += 1"
done
	printf "%s\n" \
	    "$line2"
	printf " %s\n " \
		" :.: Для установки набрать: mm номер" \
		"    Пример: mm.sh 3 [ загрузка 2024.sh ] " \
	    " " \
		":.: mm.sh -h    -- вызов справки"		
    exit 66 # for mmload.sh script    
}


version() {
	printf " %s\n" \
	          " " \
              ":.: $SCRIPTNAME - My Manager ( themes for t-ui )" \
	          ":.: Версия программы  $VER от $DATERELEASE "	
	exit 77 #for mmload.sh script
}


load_chosen_theme() {
cd $HOME && rm -rf $TUI
printf "%${padding1}s%s\n" \
              " Прогресс выполнения: " "$PERCENT1" \
              "" ""
if [[ ! -d TEMP ]]
    then mkdir /storage/emulated/0/TEMP
    else rm -rf /storage/emulated/0/TEMP && mkdir /storage/emulated/0/TEMP
sleep 0.5; printf "%${padding1}s%s\n" \
              " Прогресс выполнения: " "$PERCENT2"\
	      ""
    echo " :.: Создана папка для тем tui"
fi
    temp="/storage/emulated/0/TEMP"
    cd $temp
sleep 0.5; printf "%${padding1}s%s\n" \
              " Прогресс выполнения: " "$PERCENT3"\
	      ""
    printf " Скачивание... \n"
sleep 0.5; printf "%${padding1}s%s\n" \
              " Прогресс выполнения: " "$PERCENT4"\
	      ""
sleep 0.5; printf "%${padding1}s%s\n" \
              " Прогресс выполнения: " "$PERCENT5"\
	      ""
sleep 0.5; printf "%${padding1}s%s\n" \
              " Прогресс выполнения: " "$PERCENT6"\
	      ""
    curl -LJO -s $LINK/$CHOSEN_THEME$ZP &&  echo "     - загрузка --> успешно" || echo "     - ошибка загрузки"
sleep 0.5; printf "%${padding1}s%s\n" \
              " Прогресс выполнения: " "$PERCENT7" \
	      ""
    unzip -d $HOME -q $CHOSEN_THEME$ZP &&  echo "     - распаковка --> успешно" || echo "     - ошибка распаковки"

sleep 0.5; printf "%${padding1}s%s\n" \
              " Прогресс выполнения: " "$PERCENT8"\
	      ""
cd $SCRIPTDIR
    curl -LJO -s $scriptlink/scripto.sh
    curl -LJO -s $scriptlink/scriptman.sh
    curl -LJO -s $scriptlink/mm.sh
    curl -LJO -s $scriptlink/mmload.sh
    echo " ">>$TUIDIR/alias.txt
    echo "scriptio =sh /storage/emulated/0/scriptio.sh %">>$TUIDIR/alias.txt
sleep 0.5; printf "%${padding1}s%s\n" \
              " Прогресс выполнения: " "$PERCENT9" \
	      ""
}


remove_tmpfiles() {
sleep 0.5; printf "%${padding1}s%s\n" \
              "" " Удаляю временные файлы" \
              " Прогресс выполнения: " "$PERCENT10" \
              """"
    rm -rf $temp
sleep 0.5; printf "%${padding1}s%s\n" \
              " Прогресс выполнения: " "$PERCENT11" \
	      ""
    printf "%s\n" " :.:  Папка временных файлов удалена" \
               " "
    printf "%${padding1}s%s\n" \
              " Прогресс выполнения: " "$PERCENT12"\
	      ""
}




## index=$(($1-1))
##CHOSEN_THEME="{THEME_LIST[$index]}"

case "$1" in
    [1-$LIMIT])
	index=`expr $1 - 1` # Allowed index=$(($1-1))
	CHOSEN_THEME="${THEME_LIST[$index]}"
        ;;
    -l|--list|%)
        show_theme
        ;;  
    -v|--version)
        version
        ;;
    -h|--help)
		show_help
        ;;
    *)
        printf " :.: Недействительный аттрибут.\n";sleep 1.0
        printf " \n"    
        show_help
        exit 1
        ;;
esac


## START PROG HERE

print_header_mmpic
load_chosen_theme
remove_tmpfiles
print_end
