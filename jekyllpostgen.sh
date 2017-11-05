#! /bin/bash

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

function config {
    # Post layout
    layout="post"

    # Post text editor
    editor="cat"

    # Post directory
    folder="./"

    # Default date format in posts
    default_date_format_in_post='%F %T %z'

    # Default category (space separated values)
    default_category="EN"

    tag_format_is_brackets=true
}

function show_help {
    echo ""
    echo "Usage: $(basename "$1") \"Post title\""
    echo ""
    echo "For interactive mode use: $(basename "$1") -i"
    echo ""
    exit 0
}

function do_interactive_mode {
    read -rp "Enter Title: " title
    read -rp "Enter Href (link): " href
    read -rp "Enter Tags (comma separated): " tags
    read -rp "Enter Categories (space separated): " categories
}

function set_filename {
    # convert title to jekyll post filename format 
    # echo part replaces spaces with '-', awk converts it to lowercase
    # sed keeps only lowercase letters and '-' and 0-9 digits
    filetitle=$( echo "${1// /-}" | awk '{print tolower($0)}'| sed 's/[^a-z0-9\-]*//g')

    filename="${folder}$(date +%F)-$filetitle.md"
}

config

is_interactive=false
is_basic_mode=false

# show help with -h or --help, set interactive mode with -i, no params show help, no second params basic mode
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  show_help "$0"
elif [[ "$1" == "-i" ]]; then
  is_interactive=true
elif [ -z "$1" ]; then
  show_help "$0"
elif [[ -z "$2" && "$is_interactive" = false ]]; then
  is_basic_mode=true
fi

# if is_interactive is false an received a "-" in first param, show help
if [[ ${1:0:1} == "-" && "$is_interactive" = false ]]; then
    show_help "$0"
fi


##### Variables #####
if [[ "$is_interactive" = true ]]; then
    do_interactive_mode
elif [[ "$is_interactive" = false && "$is_basic_mode" = false ]]; then
    OPTIND=2
    while getopts "l:t:c:" option; do
        case "${option}" in
            t) tags=${OPTARG};;
            l) href=${OPTARG};;
            c) categories=${OPTARG};;
        esac
    done
    title="$1"
else
    title="$1"
fi

set_filename "$title"

date=$(date +"$default_date_format_in_post")

########## Adding to file ##########
{
    echo "---"
    echo "layout: ${layout}"
    echo "title: \"${title}\""
} >> "$filename"

if [[ "$is_basic_mode" = false ]]; then

  ### Adding href to file
  if [ "$href" ]; then
    echo "href: $href" >> "$filename"
  fi

  ### Adding date to file
  echo "date: $date" >> "$filename"

  ### Adding tags
  if [ "$tags" ]; then
    if [[ "$tag_format_is_brackets" = true ]]; then
        echo "tags: [$tags]" >> "$filename"
    else
    # The lack of indentation here is necessary 
        echo "tags:
- $tags" | sed 's/,/\
-/g' >> "$filename"
    fi
  fi

  ### Adding categories
  if [ "$categories" ]; then
    echo "categories: $categories" >> "$filename"
  else
    echo "categories: ${default_category}" >> "$filename"
  fi

fi

echo "---" >> "$filename"
# echo >> "$filename"

echo "Your new filename is: $filename"

# open in chosen editor
${editor} "$filename"
