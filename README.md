# OpenSCAD Braille

Library for OpenSCAD for converting strings into Braille.

## Dependencies

This code has one dependency as a submodule:
[funcutils](https://github.com/thehans/funcutils/tree/master).

So, before using it you'll need to run:

~~~bash
git submodule update --init
~~~

## How to use

~~~scad
use <braille.scad>

$fn = 30;

braille("Hello world"); // generates a 3D braille with the default $fn

braille("Hello world", $fn=60); // generates a 3D braille with $fn = 60

braille("Hello world"); // generates a 2D braille
~~~
