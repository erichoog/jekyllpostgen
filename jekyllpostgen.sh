#!/bin/bash

#--------jekyllpostgen--------#
#
# Source and tweaked from:
#   https://gist.github.com/marcusoftnet/2eec785d3477beacf709#file-scaffold_post
#   https://gist.github.com/marcusoftnet/2eec785d3477beacf709#file-scaffold_post
#
#-----------------------------#

# Simply put the script in your site directory, edit the configs to fit your setup, and run it with:
# ./jekyllpostgen.sh "post title"

# What is does:
# - creates the post with the correct format of date and title
# - adds YAML front-matter (layout, title, date, tags)
# - opens the post file in editor chosen

# EXAMPLE OUTPUT:

# ---
# layout: post
# title: "A Canvas of the Minds"
# href: https://acanvasoftheminds.com/
# date: 2017-10-27 22:57:09 -0400
# tags: [wordpress, personal_stories, collaborative, blogs]
# categories: EN
# ---

########## Configs ##########

# Post layout
layout="post"

# Post text editor
editor="cat"

# Post directory
folder="_posts/"

# Default date formate in posts
default_date_format_in_post='%F %T %z'

# Default category (space separated values)
default_category="EN"


########## Program ##########

# show help with -h
if [ "$1" == "-h" ]; then
  echo "Usage: `basename $0` \"Post title\""
  exit 0
elif [ -z "$1" ]; then
  echo "Usage: `basename $0` \"Post title\""
  exit 0
fi

##### Variables #####

# post title
title="$1"

# convert title to filename format
# echo part replaces spaces with '-'
# awk converts it to lowercase
# sed keeps only lowercase letters and '-'
filetitle=$( echo ${1// /-} | awk '{print tolower($0)}'| sed 's/[^a-z\-]*//g')

# name of file
filename="${folder}`date +%F`-$filetitle.md"
echo $filename

date=$(date +"$default_date_format_in_post")

########## Adding to file ##########
echo "---" >> $filename
echo "layout: ${layout}" >> $filename
echo "title: \"$title\"" >> $filename

### Adding href to file
read -p "Href: " href
if [ "$href" ]; then
  echo "href: $href" >> $filename
fi

echo "date: $date" >> $filename

### Adding tags
read -p "Tags: " tags
if [ "$tags" ]; then
  echo "tags: [$tags]" >> $filename
fi

echo "categories: ${default_category}" >> $filename

echo "---" >> $filename
echo >> $filename

# open in chosen editor
${editor} $filename
