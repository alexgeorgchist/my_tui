#!/bin/sh

huchline="++++++++++++++++++++++++++++++++++++++++++++++++"
file="/storage/emulated/0/t-ui/script_texts/6psalm.txt"
home="/storage/emulated/0"

#head -10 $file           #Psalom 3
#sed -n 12,35p $file   #Psalom 37
#sed -n 37,49p $file   #Psalom 62
#sed -n 51,70p $file   #Psalom 87
#sed -n 72,95p $file   #Psalom 102
#sed -n 97,110p $file #Psalom 142

print_header () {
printf " \n"
printf "%s\n" \
          "=============================================" \
          "                ШЕСТОПСАЛМИЕ                                  " \
          "============================================="
           printf " \n"
}

print_end () {
        printf "============================================="
        printf " \n"
exit 0
}

print_6p_all () {
        head -10 $file #Psalom 3
            echo "$huchline"
        sed -n 12,35p $file #Psalom 37
            echo "$huchline"
        sed -n 37,49p $file #Psalom 62
            echo "$huchline"
            printf " \n"
            echo "               Слава и ныне"
            echo "                Аллилуия 3р."
            printf " \n"
            echo "$huchline"
        sed -n 51,70p $file #Psalom 87
            echo "$huchline"
        sed -n 72,95p $file #Psalom 102
            echo "$huchline"
        sed -n 97,110p $file #Psalom 142
        printf " \n"
}


case "$1" in
    1|p3)
	    head -10 $file #Psalom 3
        ;;
    2|p37)
        sed -n 12,35p $file #Psalom 37
        ;;  
    3|p62)
        sed -n 37,49p $file #Psalom 62
        ;;
     4|p87)
		sed -n 51,70p $file #Psalom 87
        ;;
     5|p102)
		sed -n 72,95p $file #Psalom 102
        ;;
      6|p142)
        sed -n 97,110p $file #Psalom 142
        ;;
       *)
print_header
print_6p_all
print_end
        ;;
esac
