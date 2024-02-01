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

### Use as a library

You can use this as a library that can generate Braille for you model:

~~~scad
use <braille.scad>

$fn = 30;

braille("Hello world"); // generates a 3D braille with the default $fn

braille("Hello world", $fn=60); // generates a 3D braille with $fn = 60

braille("Hello world"); // generates a 2D braille
~~~

### Use as a parametric model

You can also use this as a parametric model. At the end of the file there's a
little code snippet that generates a plate with a Braille text. You can change
using the parameter `input_text`.
