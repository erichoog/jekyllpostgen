# jekyllpostgen
A Jekyll Post Generator for BASH

[![Build Status](https://travis-ci.org/erichoog/jekyllpostgen.svg?branch=master)](https://travis-ci.org/erichoog/jekyllpostgen)



# Usage

The filename will always output in this format: `YYYY-MM-DD-your-file-title.md`

In the config function at the top of the script, the editor is set to `cat` by default so the file contents will be opened with that program at the end.

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

## Command-line Options:

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

This is done in the config function block at the top of the script.
```
function config {

}
```

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


Credit / Inspired by: 
- [Jekyll Post Creator](http://www.marcusoft.net/2014/12/my-post-scaffolder-for-jekyll.html)
- [jekyll-posts-generator](https://github.com/ismnoiet/jekyll-posts-generator)
