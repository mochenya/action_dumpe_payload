#!/usr/bin/env bash

func(){
    echo "Usage:"
    echo "download.sh [-l ROM_Link] [-n ROM_Name]"
    echo "Description:"
    echo "ROM_Link is Full OTA download link"
    echo "ROM_Name is save name, don't add with .zip"
    exit 1
}

while getopts ":l:n:h" opt; do
    case $opt in
        l)
            l=$OPTARG
            ;;
        n)
            n=$OPTARG
            ;;
        h)
            func
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            func
            exit 1
            ;;
    esac
done

download(){
    file="$n.zip"
    if ! [ -x "$(command -v aria2c)" ]; then
        echo "aria2 not installed." >&2
        exit 1
    fi

    aria2c -s16 -x16 -k1M "$l" -o "$file"
    
    if [ -e "$file" ]; then
        unzip "$file" payload.bin -d .
        if [ -e "payload.bin" ]; then
            chmod -R 0777 ./*
            echo "Done!"
        else
            exit 1
        fi
    else
        echo "File not found! Try again."
        aria2c -s16 -x16 -k1M "$l" -o "$file"
    fi
}

if [ -z "$l" ] || [ -z "$n" ]; then
    echo "Error: Missing required parameters."
else
    download
fi
