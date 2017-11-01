#!/bin/bash

#---------/---------------------\---------#
#--------|- Jekyll Post Creator -|--------#
#---------\---------------------/---------#
# Ripped and tweaked from https://gist.github.com/kabrooski/6107707

# Simply put the script in your site directory, edit the configs to fit your setup, and run it with:
# ./post "post title"

# What is does:
# - creates the post with the correct format of date and title
# - adds YAML front-matter (layout, title, date, tags)
# - opens the post file in editor chosen


########## Configs ##########

# Post layout
layout=post

# Post text editor
editor=sublime

# Post directory
folder=_posts/

# Author
author="Marcus Hammarberg"

########## Program ##########

# show help with -h
if [ "$1" == "-h" ]; then
  echo "Usage: `basename $0` \"Post title\""
  exit 0
elif [ -z "$1" ]; then
  echo "Usage: `basename $0` \"Post title\""
  exit 0
fi

# Y/n ask function
function ask {
    while true; do

        if [ "${2:-}" = "true" ]; then
            prompt="Y/n"
            default=Y
        elif [ "${2:-}" = "false" ]; then
            prompt="y/N"
            default=N
        else
            prompt="y/n"
            default=
        fi

        # Ask the question
        read -p "$1 [$prompt] " REPLY

        # Default?
        if [ -z "$REPLY" ]; then
            REPLY=$default
        fi

        # Check if the reply is valid
        case "$REPLY" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac

    done
}

##### Variables #####

# post title
title="$1"

# convert title to filename format
# echo part replaces spaces with '-'
# awk converts it to lowercase
# sed keeps only lowercase letters and '-'
filetitle=$( echo ${1// /-} | awk '{print tolower($0)}'| sed 's/[^a-z\-]*//g')

# name of file
filename="$folder`date +%F`-$filetitle.md"
echo $filename


########## Adding to file ##########
echo "---" >> $filename
echo "layout: $layout" >> $filename
echo "title: \"$title\"" >> $filename
echo "author: \"$author\"" >> $filename
echo "date: `date +%F\ %H:%M:%S`" >> $filename


### Adding tags on new lines with a dash in front (separated with comma)
read -p "Tags: " tags
if [ "$tags" ]; then
  echo "tags:
- $tags" | sed 's/,/\
-/g' >> $filename
fi

echo "---" >> $filename
echo >> $filename

# open in chosen editor
$editor $filename
