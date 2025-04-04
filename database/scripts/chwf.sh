#!/system/bin/sh
# chwf - Change Weather Format
# Description: A t-ui theme script to build and modify information
#              displayed on the weather status line.
#
# By: DeadRabbit
# Telegram: @deadrabbit404

PROGNAME=${0##*/}
ATTRNUM_ARRAY=()

# Weather format for each attribuite
WEATHER="#[Thunderstorm\/ ][Drizzle\/ ][Rain\/ ][Snow\/ﰕ ][Mist\/ ][Smoke\/ ][Haze\/ ][Dust\/ ][Fog\/ [Sand\/ ][Ash\/ ][Squall\/ ][Tornado\/ ][Clear\/ ][Clouds\/ ]%main %description"
TEMPC=" %temp°C"
TEMPF=" %temp\$(*9\/5+32)°F"
TEMPK=" %temp\$(+273.15)°K"
PRESSURE=" %pressure\$(*0.750064) mmHg"
HUMIDITY=" %humidity%"
VISIBILITY="  %visibility\$(\/1000) km"
SPEEDKM="龍   %speed\$(*3.6) км\/ч"
SPEEDM="龍   %speed м\/с"
LOCATION=" %name"
COORD=" [%lat, %lon]"

# The location of behavior.xml
TARGET="/storage/emulated/0/t-ui/behavior.xml"
BACKUPFILE="/storage/emulated/0/t-ui/behavior.xml.bak"

print_header () {
    printf "%s\n" \
        "################################"\
        "#                              #"\
        "# $PROGNAME - Смена формата Погоды  #"\
        "#                              #"\
        "################################"\
    
    printf " \n"
}

show_help () {
# Print help and usage message
    padding=-14
    print_header
    printf "%s\n" \
        "Использование:" \
"$PROGNAME [-h, --help] [-a, --attrs]" \
        "     [-r, --restore] [N1 N2 N3...]"

    printf " \n"
    printf "  %${padding}s %s\n" \
        "N1 N2 N3..." "Числа, соответствующие каждой погодной атрибутике" \
        "-a, --attrs" "Показать доступные погодные атрибуты." \
        "-r, --restore" "Восстановить предыдущий формат." \
        "-h, --help" "Смотреть справку."

    exit 1

}

show_weather_attrs () {
# show available formats
    print_header
    printf "Доступные погодные атрибуты:\n \n"
    printf "  %s\n" \
        "[0] Температура °K" \
        "[1] Температура °C" \
        "[2] Температура °F" \
        "[3] Атмосферное давление" \
        "[4] Влажность" \
        "[5] Видимость" \
        "[6] Скорость ветра км/ч" \
        "[7] Скорость ветра м/с" \
        "[8] Локация" \
        "[9] Координаты"

    printf " \nЗначит так: я могу выбрать несколько атрибутов, разделенных пробелом.
\n"
    printf "Пример: \`chwf 7 1 2 4\`\n"

    exit 0

}

build_format () {
# Join all the weather attributes
    glue=" • "
    for i in ${ATTRNUM_ARRAY[@]}
    do
        case $i in
            0)
                format="${format:+"$format$glue"}$TEMPK"
                ;;
            1)
                format="${format:+"$format$glue"}$TEMPC"
                ;;
            2)
                format="${format:+"$format$glue"}$TEMPF"
                ;;
            3)
                format="${format:+"$format$glue"}$PRESSURE"
                ;;
            4)
                format="${format:+"$format$glue"}$HUMIDITY"
                ;;
            5)
                format="${format:+"$format$glue"}$VISIBILITY"
                ;;
            6)
                format="${format:+"$format$glue"}$SPEEDKM"
                ;;
            7)
                format="${format:+"$format$glue"}$SPEEDM"
                ;;
            8)
                format="${format:+"$format$glue"}$LOCATION"
                ;;
            9)
                format="${format:+"$format$glue"}$COORD"
        esac
    done
    
    echo "$format"
}

restore_format () {
# Restore previous weather format
    if [ -f "$BACKUPFILE" ]
    then
        echo ":: Восстановление предыдущего формата погоды..."
        sleep 1
        mv "$BACKUPFILE" "$TARGET"
        echo ":: Сделано. Пожалуйста, перезагрузите t-ui."
    else
        echo "Предыдущий формат не найден. Прервано..."
    fi
    exit $?
}

replace_weather () {
# Replace the current weather format with
# the attributes chosen by the user

    format=`build_format`
    printf ":: Замена погодных атрибутов, пожалуйста, подождите...\n"
    sleep 1

    # Search and replace operation
    sed -i.bak "s/\(<weather_format value=\"\).*\(\"\/>\)/\1$format\2/" $TARGET

    # Verify if operation is successful
    [ $? -eq 0 ] \
        && printf ":: Успешно! Пожалуйста, перезагрузите t-ui.\n" \
        || printf ":: Операция провалилась!: Произошла ошибка.\n"
}

# Script starts here
# Show list of weather attributes
# when invoke without parameter.
[ $# -eq 0 ] && show_weather_attrs

for arg in $@
do
    case $arg in
        -h|--help)
            show_help
            ;;
        -r|--restore)
            restore_format
            ;;
        -a|--attrs|%)
            show_weather_attrs
            ;;
        [0123456789])
            ATTRNUM_ARRAY+=($arg)
            ;;
        *)
            printf "Недопустимый параметр/аргумент: '$arg'. Попробуйте снова\n"
            exit 1
    esac
done

replace_weather
