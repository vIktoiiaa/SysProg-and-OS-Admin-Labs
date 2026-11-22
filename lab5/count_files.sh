#!/bin/bash

if [ -f /etc/count_files.conf ]; then
    . /etc/count_files.conf
fi

if [ -n "$1" ]; then
    TARGET_DIR="$1"
elif [ -z "$TARGET_DIR" ]; then
    TARGET_DIR="/etc"
fi

if [ -n "$2" ]; then
    EXTENSION="$2"
elif [ -z "$EXTENSION" ]; then
    EXTENSION="conf"
fi

if [ ! -d "$TARGET_DIR" ]; then
    echo "Помилка: директорія $TARGET_DIR не існує"
    exit 1
fi

count_items() {
    local dir=$1
    local type=$2
    find "$dir" -maxdepth 1 -type "$type" 2>/dev/null | wc -l
}

files=$(count_items "$TARGET_DIR" "f")
dirs=$(count_items "$TARGET_DIR" "d")
links=$(count_items "$TARGET_DIR" "l")

ext_count=$(find "$TARGET_DIR" -maxdepth 1 -type f -name "*.$EXTENSION" 2>/dev/null | wc -l)

recursive_count=$(find "$TARGET_DIR" -type f 2>/dev/null | wc -l)

total_size=$(find "$TARGET_DIR" -maxdepth 1 -type f -exec du -b {} + 2>/dev/null | awk '{sum+=$1} END {print sum}')

if [ -z "$total_size" ]; then
    total_size=0
fi

echo "Статистика директорії $TARGET_DIR:"
echo "  Звичайні файли: $files"
echo "  Директорії: $((dirs - 1))"
echo "  Символічні посилання: $links"
echo "  -------------------------"
echo "  Файли з розширенням .$EXTENSION: $ext_count"
echo "  -------------------------"
echo "  Всього файлів (рекурсивно): $recursive_count"
echo "  -------------------------"
echo "  Загальний розмір: $total_size байт"
echo " Звіт згенеровано: $(date '+%Y-%m-%d %H:%M:%S')"
