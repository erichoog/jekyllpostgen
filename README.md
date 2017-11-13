# jekyllpostgen
A Jekyll Post Generator for BASH

[![Build Status](https://travis-ci.org/erichoog/jekyllpostgen.svg?branch=master)](https://travis-ci.org/erichoog/jekyllpostgen)


> This documentation is currently incomplete


The **jekyllpostgen** script is meant to make it easier to create post files for [Jekyll](https://jekyllrb.com/) website projects.  

It creates the post files with the proper filename format for Jekyll posts including the date and a lowercase slugified version of the title you input. 

It accepts input for different parts of the post [YAML Front Matter](https://jekyllrb.com/docs/frontmatter/) and allows you to configure different aspects of how that input is handled, such as the tag formatting or the file extension (see [Configuration](#configuration) section).

You can use the script in three different ways: [Basic](#basic), [Interactive](#interactive), and [Command-line](#command-line).

The filename will always output in this format: `YYYY-MM-DD-your-file-title.md` and is created in the same directory where **jekyllpostgen** is run by default.

Once the program has completed creating the file, it opens the file in the specified editor which is `cat`. So you can easily see what the output file looks like.  This can be configured to open any text editor you have installed like `nano` or `sublime`.

# Usage

## Basic:

`./jekyllpostgen.sh "Your File Title"`

This will create a file with this format:

```
---
layout: post
title: "Your File Title"
---
```

## Interactive:

`./jekyllpostgen.sh -i`

This will read in Title, Href, Tags, and Categories one by one:
```
Enter Title: "Your File Title"
Enter Href (link): https://test.com
Enter Tags (comma separated): test1, test with space, test2
Enter Categories (space separated): DE
```

This will create a file with this format:
```
---
layout: post
title: "Your File Title"
href: https://test.com
date: 2017-11-02 09:23:57 -0400
tags: [test1, test with space, test2]
categories: DE
---
```

## Command-line:

`./jekyllpostgen.sh "Your File Title" -t "tag1, tag with space, tag3" -l https://test.com -c DE`

This will create a file with this format:
```
---
layout: post
title: "Your File Title"
href: https://test.com
date: 2017-11-02 09:30:07 -0400
tags: [tag1, tag with space, tag3]
categories: DE
---
```

> NOTE: for -t and -c options you can use double quotes for multiple options or ommit them for one.

# Configuration

There are two methods of configuration availalbe.
1. Creating a `.jekyllpostgenrc` file in your home directory.
2. Modifying the `config` function at the beginning of the script file

## Using the .jekyllpostgenrc file

To use the `.jekyllpostgenrc` config file just copy the `jekyllpostgenrc.example` file to your home directory and rename it to `.jekyllpostgenrc`.

You can do this from the root of the repository using `cp jekyllpostgenrc.example ~/.jekyllpostgenrc`.

## Using the script config function

This is done in the config function block at the top of the script.
```
function config {

}
```

The file extension defaults to `.md`


## Tag Format Options

The default tag format is the brackets format: `tags: [tag1, tag2, tag3]`

This is set with the `tag_format_is_brackets=true` option in the config function.

To change this to the hyphenated format: 

```
tags:
- tag1
- tag2
- tag3
```

Set the `tag_format_is_brackets` option to `false`:  `tag_format_is_brackets=false`

## Other

For info on unit testing scripts see [TESTING.md](TESTING.md)

## Credit / Inspired by: 
- [Jekyll Post Creator](http://www.marcusoft.net/2014/12/my-post-scaffolder-for-jekyll.html)
- [jekyll-posts-generator](https://github.com/ismnoiet/jekyll-posts-generator)
