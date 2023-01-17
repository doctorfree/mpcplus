# What `terminal_dimensions` Does

This is a tiny command line tool written in C that reports terminal
dimensions, both in character cells and in pixels, e.g.,

~~~
$ terminal_dimensions
141 43 2538 1548
~~~

This is helpful, because, as far as I can tell, standard cli tools, like `tput`, don't report pixel
dimensions. Unfortunately, in many emulators, the pixel dimensions will be misreported as 0 and 0:

~~~
$ terminal_dimensions
141 43 0 0
~~~

So that makes this less helpful than it could be.

# Installation

Compile:

    $ gcc terminal_dimensions.c -o terminal_dimensions

Then move `terminal_dimensions` to somewhere in your path, e.g., `/usr/local/bin`.



