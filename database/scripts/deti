#!/bin/sh

SCRIPTNAME=${0##*/}

line1="----------------------------------------------"
line2="=============================================="
TXTDIR="/storage/emulated/0/t-ui/script_texts"
FILE="/storage/emulated/0/t-ui/script_texts/deti.txt"
ANGELFILE="/storage/emulated/0/t-ui/script_texts/angel.txt"
weekday=`date +%u`

print_header() {
    printf "%s\n" \
              $line2 \
              "              Молитвы о детях." \
              $line2
}
     
     
print_detifile () {
a1="крестнике"
b1="Крестьянкина"
c1="Богородице"
d1="Хранителю"
e1="Аминь."
f1="Молитва"
DOT="•"
    cd $TXTDIR
while IFS= read -r string; do
    a2=`echo $string | tail -c 19`   # 9letters*2 + 1 = 19
    b2=`echo $string | tail -c 25`   # 12letters*2 + 1= 25
    c2=`echo $string | tail -c 21`   # 10letters*2 + 1 = 21
    d2=`echo $string | tail -c 19`   # 9letters*2 +1 = 19
    e2=`echo $string | tail -c 12`   # 5letters*2 +dot[1] + 1 = 12
    f2=`echo $string | head -c 14` # 7letters*2 + 1 = 15

if [ "$f2" = "$f1" ]; then printf " $DOT "; fi
if [ "$x" = 1 ]
    then echo "$string" | awk '{print toupper($0)}' #small text to BIG text
    else echo "$string"
fi
if [ "$a2" = "$a1" ] || [ "$b2" = "$b1" ] || [ "$c2" = "$c1" ] || [ "$d2" = "$d1" ]
    then printf "%s\n" \
                       " "
    elif [ "$e2" = "$e1" ]
    then printf "%25s%s\n" \
                       "***"
    else continue
fi   

done < deti.txt 
}

## angel
print_angelfile () {
if [ "$weekday" -eq 1 ]; then head -6 $ANGELFILE
    elif [ "$weekday" -eq 2 ]; then sed -n 8,13p $ANGELFILE
        elif [ "$weekday" -eq 3 ]; then sed -n 15,20p $ANGELFILE
            elif [ "$weekday" -eq 4 ]; then sed -n 22,28p $ANGELFILE
                elif [ "$weekday" -eq 5 ]; then sed -n 30,35p $ANGELFILE
                    elif [ "$weekday" -eq 6 ]; then sed -n 37,42p $ANGELFILE
                        else sed -n 44,49p $ANGELFILE
fi
}


## optina

print_optinafile () {
printf "%s\n" $line1
printf "%-12s"\
           " " "Молитва оптинских старцев."\
           " "
b="."
    cd $TXTDIR
while IFS= read -r string;do
a=`echo $string | tail -c 3`
    echo "$string"
    if [ "$a"="$b" ]
        then printf " %s\n"
    fi
done < optina.txt
printf $line2
exit 0
}

## Choosing a print option (big small)
case "$1" in
        1)
            x=1
            ;;
        *)
            x=0
            ;;
esac

print_header
print_detifile
print_angelfile
print_optinafile