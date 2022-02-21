#!/usr/bin/env bash

#     ░██████╗██╗░░██╗░█████╗░░██╗░░░░░░░██╗  ███████╗██╗██╗░░░░░███████╗  ████████╗░█████╗░░██████╗░░██████╗
#     ██╔════╝██║░░██║██╔══██╗░██║░░██╗░░██║  ██╔════╝██║██║░░░░░██╔════╝  ╚══██╔══╝██╔══██╗██╔════╝░██╔════╝
#     ╚█████╗░███████║██║░░██║░╚██╗████╗██╔╝  █████╗░░██║██║░░░░░█████╗░░  ░░░██║░░░███████║██║░░██╗░╚█████╗░
#     ░╚═══██╗██╔══██║██║░░██║░░████╔═████║░  ██╔══╝░░██║██║░░░░░██╔══╝░░  ░░░██║░░░██╔══██║██║░░╚██╗░╚═══██╗
#     ██████╔╝██║░░██║╚█████╔╝░░╚██╔╝░╚██╔╝░  ██║░░░░░██║███████╗███████╗  ░░░██║░░░██║░░██║╚██████╔╝██████╔╝
#     ╚═════╝░╚═╝░░╚═╝░╚════╝░░░░╚═╝░░░╚═╝░░  ╚═╝░░░░░╚═╝╚══════╝╚══════╝  ░░░╚═╝░░░╚═╝░░╚═╝░╚═════╝░╚═════╝░
#                        Script to list all tags for each file at given directgory

RED="\e[31m"
GREEN="\e[32m"
LIGHT_YELLOW="\e[93m"
BLUE="\e[34m"
PURPLE="\e[35m"
ENDCOLOR="\e[0m"
CYAN="\e[36m"
STATS=0

# macosTags read ./$1/* --verbose >./artifacts.txt
# input="./artifacts.txt"

usage() {
    cat <<EOF
usage: $0 options iprange

OPTIONS:
   -a      set a option
   -b      set b option
   -r      set rangei, e.g 1 10
EOF
}

# Assume you already installed macosTags, and you have a directory with all your files-tags

while [ "$1" != "" ]; do
    macosTags read $2/* --verbose >./artifacts.txt
    input="./artifacts.txt"

    case $1 in

    -f | --file)

        local FILE_COUNT=1
        local TAG_COUNT=1
        while IFS= read -r line || [[ -f $line ]]; do
            FILENAME=$(echo -e "$line" | awk -F "." '{print $2}' | awk -F "/" '{print $3}')
            echo -e "${BLUE}[${LIGHT_YELLOW}$FILE_COUNT${BLUE}]${CYAN} \ue27c  ${PURPLE} $FILENAME${ENDCOLOR}"
            tagsList=$(echo "$line" | awk -F "." '{print $3}')
            for tag in $tagsList; do
                if [[ $tag != "pdf" ]]; then
                    echo -ne "   ${BLUE}[${LIGHT_YELLOW}$FILE_COUNT${ENDCOLOR}"${BLUE}-"${LIGHT_YELLOW}$TAG_COUNT${BLUE}]"...."${LIGHT_YELLOW} \uf02b: ${RED}${tag}${ENDCOLOR}\n"
                    TAG_COUNT=$((TAG_COUNT + 1))
                fi
            done
            FILE_COUNT=$((FILE_COUNT + 1))
            TAG_COUNT=1

        done <"$input"
        exit 1

        ;;
    -s | --searching)
        shift 2
        SEARCHING_TAG=$1
        cat ./artifacts.txt | grep "$1" >./search.txt
        input2="./search.txt"
        while IFS= read -r line || [[ -f $line ]]; do
            echo -e "${BLUE}[${LIGHT_YELLOW}$SEARCHING_TAG${BLUE}]${CYAN} \ue27c  ${PURPLE} $line${ENDCOLOR}"
        done <"$input2"

        exit 1
        ;;
    -h | --help)
        usage
        exit
        ;;
    -t | --test)
        testing
        exit 1
        ;;
    -e | --export)
        shift
        macosTags read $1/* --verbose >./tags.tsv
        exit 1
        ;;

    -w | --write-tags)
        # For currently directory only you can write tags to all files, based on the exported tags.tsv in -e|--export
        while IFS=$'\t' read -r -a FILETAGS; do
            # debug
            # echo "${FILETAGS}" "............." "${FILETAGS[@]:1}"
            macostags write "${FILETAGS}" "${FILETAGS[@]:1}"
            echo -e "${RED} Written tags to File :[${STATS}]\n\n${LIGHT_YELLOW} \ue27c::${GREEN}${FILETAGS}:\n"
            STATS=$((STATS + 1))
            for tag in ${FILETAGS[@]:1}; do
                echo -e "${BLUE}\uf02b::${LIGHT_YELLOW} ${tag}"
            done
        done <./tags.tsv

        echo -e "${PURPLE}****************"
        echo -e "${CYAN}Total files tags written: ${PURPLE}${STATS}"
        exit 1
        ;;

    *)
        exit 1
        ;;
    esac
done


