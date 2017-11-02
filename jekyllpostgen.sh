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

function show_help {
    echo ""
    echo "Usage: `basename $1` \"Post title\""
    echo ""
    echo "For interactive mode use: `basename $1` -i"
    echo ""
    exit 0
}

is_interactive=false
is_basic_mode=false

do_interactive_mode() {
  read -p "Enter Title: " title
  read -p "Enter Href (link): " href
  read -p "Enter Tags (comma separated): " tags
  read -p "Enter Categories (space separated): " categories
}

# show help with -h or --help, set interactive mode with -i, no params show help, no second params basic mode
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  show_help $0
elif [[ "$1" == "-i" ]]; then
  is_interactive=true
elif [ -z "$1" ]; then
  show_help $0
elif [[ -z "$2" && "$is_interactive" = false ]]; then
  is_basic_mode=true
else
  is_interactive=false
  is_basic_mode=false
fi

# if is_interactive is false an received a "-" in first param, show help
if [[ ${1:0:1} == "-" && "$is_interactive" = false ]]; then
  show_help $0
fi


##### Variables #####
if [[ "$is_interactive" = true ]]; then
  do_interactive_mode
else
  title="$1"
fi

OPTIND=2
while getopts "l:t:c:" option; do
 case "${option}" in
  t) tags=${OPTARG};;
  l) href=${OPTARG};;
  c) categories=${OPTARG};;
 esac
done


# convert title to filename format
# echo part replaces spaces with '-'
# awk converts it to lowercase
# sed keeps only lowercase letters and '-' and 0-9 digits
filetitle=$( echo ${title// /-} | awk '{print tolower($0)}'| sed 's/[^a-z0-9\-]*//g')

# name of file
filename="${folder}`date +%F`-$filetitle.md"
echo $filename

date=$(date +"$default_date_format_in_post")

########## Adding to file ##########
echo "---" >> $filename
echo "layout: ${layout}" >> $filename
echo "title: \"$title\"" >> $filename

if [[ "$is_basic_mode" = false ]]; then

  ### Adding href to file
  if [ "$href" ]; then
    echo "href: $href" >> $filename
  fi

  ### Adding date to file
  echo "date: $date" >> $filename

  ### Adding tags
  if [ "$tags" ]; then
    echo "tags: [$tags]" >> $filename
  fi

  ### Adding categories
  if [ "$categories" ]; then
    echo "categories: $categories" >> $filename
  else
    echo "categories: ${default_category}" >> $filename
  fi

fi

echo "---" >> $filename
echo >> $filename

# open in chosen editor
${editor} $filename
