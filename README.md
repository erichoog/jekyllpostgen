# jekyllpostgen
A Jekyll Post Generator for BASH

Credit / Inspired by: 
- [Jekyll Post Creator](http://www.marcusoft.net/2014/12/my-post-scaffolder-for-jekyll.html)
- [jekyll-posts-generator](https://github.com/ismnoiet/jekyll-posts-generator)

# Usage

The filename will always output in this format: `YYYY-MM-DD-your-file-title.md`

In the config file, the editor is set to `cat` by default so the file contents will be opened with that program at the end.

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