#!/bin/bash

#####################################
# Нужно ввести день начала чтения псалтири: #
BEGINDAY=62   # Look STRASNAYA and move!!!   #
#####################################

DATENOW=`date +%j` #Number day of the year xxx-format
huchline="++++++++++++++++++++++++++++++++++++++++++++++++"
file="/storage/emulated/0/t-ui/script_texts/20molitv.txt"
arr=(32,33p 36p 39,40p 43,48p 51,53p 56,60p 63,65p 68,69p 72p 75,82p 85,86p 89,91p 94,96p 99,105p 108,111p 114,116p 119,124p 127,129p 132,134p 137,140p)


nachalo () {
printf "%s\n"\
          " " \
          "$huchline" \
          "ПСАЛТИРЬ ПО УСОПШИМ"
head -1 $file
printf " \n"
sed -n 2,3p $file
printf " \n"
sed -n 4,6p $file
printf " \n"
sed -n 8,9p $file
printf " \n"
sed -n 10,13p $file
printf " \n"
printf " \n"
sed -n 15,24p $file
printf " \n"
}

print_header () {
printf "%s\n"\
          " " \
          "$huchline" \
          "Молитва по кафизме $m :" \
          " "
}

print_end () {
        printf $huchline
        printf " \n"
exit 0
}


nomer_papa_mama_brat () {
let "KRUG1 = $BEGINDAY + 20"
let "KRUG2 = $BEGINDAY +40"
let "KRUG3 = $BEGINDAY +60"
let "KRUG4 = $BEGINDAY +80"
let "m = $DATENOW - $BEGINDAY"

if [ "$DATENOW" -ge "$BEGINDAY" ] && [ "$DATENOW" -lt "$KRUG1" ]
then let "m = $m + 1"
  elif [ "$DATENOW" -ge "$KRUG1" ] && [ "$DATENOW" -lt "$KRUG2" ] # >= && <
  then let "m = $m - 19" #  + 1 - 20
    elif [ "$DATENOW" -ge "$KRUG2" ] && [ "$DATENOW" -lt "$KRUG3" ]
    then let "m = $m - 39" #  + 1 - 40
      elif [ "$DATENOW" -ge "$KRUG3" ] && [ "$DATENOW" -lt "$KRUG4" ]
      then let "m = $m - 59" #  + 1 - 60
        elif [ "$DATENOW" -ge "$KRUG4" ] && [ "$DATENOW" -lt "$KRUG5" ]
        then let "m = $m - 79" #  + 1 - 80             
fi
}

print_molitva () {
#echo ${#arr[*]}
sed -n ${arr[$m - 1]} $file
}


nomer_papa_mama_brat
nachalo
print_header
print_molitva
print_end
