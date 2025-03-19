#!/bin/sh

SCRIPTNAME=${0##*/}

scriptdir="/storage/emulated/0/t-ui/script"
logos="/storage/emulated/0/t-ui/ascii"
line="+++++++++++++++++++++++++++++++++++++++"

## GET SCRIPT LIST
scriptlist=(6p.sh info.sh pogoda.sh pokoypsaltir.sh sysinfo.sh top_custom_info.sh topinfo.sh) # Massiv tem
limit=${#scriptlist[@]} #Number of topics in the array list

menu_script() {
	printf "%s\n" \
	           "$line"\
               "              MY SCRIPTS:"

var=1 # Number of topics in the array list LIMIT=${#THEME_LIST[@]}
    while [ "$var" -le "$limit" ] # <=
    do
    echo "   $var. ${scriptlist[$var-1]}"
var=`expr $var + 1` # Allowed var=$(($var+1)) or let "var += 1"
    done
    	printf "%s\n" \
	              "$line"
    	
    exit 0
}

going () {
cd $scriptdir
sh ./$chosen
exit 0
}


print_header () {
cat $logos/anonymous.txt
}

print_end () {
printf "   %-7s%s\n"\
          " " "Координаты заменены"\
          " " "    Restart"
}


## index=$(($1-1))
## CHOSEN_THEME="{THEME_LIST[$index]}"
case "$1" in
      [1-$limit])
      index=`expr $1 - 1` # Allowed index=$(($1-1))
  	chosen="${scriptlist[$index]}"
      going
      ;;
     *)
        printf "%s\n" $line
        print_header
        menu_script
        exit 0
        ;;
esac





