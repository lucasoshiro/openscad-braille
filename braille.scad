include <funcutils/funcutils.scad>

$fn = 30;

input_text = "Hello world";
padding = 2;
r = 1;

function all(s, predicate) = fold(true, s, function(a, b) a && predicate(b));

function is_numeric(s) = all(s, function(c) ord(c) >= ord("0") && ord(c) <= ord("9"));

function is_uppercase(s) = all(s, function(c) ord(c) >= ord("A") && ord(c) <= ord("Z"));

function get_braille_prefix(word) =
    len(word) == 0        ? []                        :
    is_numeric(word)      ? BRAILLE_NUMBER_PREFIX     :
    is_uppercase(word[0]) ? BRAILLE_CAPITALIZE_PREFIX :
    is_uppercase(word)    ? BRAILLE_UPPERCASE_PREFIX  :
    [];

function get_braille_char(c) = BRAILLE_CHARS[ord(c)];

function word_to_braille(word) = [for (c = word) get_braille_char(c)];

function str_to_braille(s) = fold(
    [],
    [
        for (word = split(s))
            concat(get_braille_prefix(word), word_to_braille(word), [BRAILLE_SPACE])
    ],
    function(a, b) concat(a, b));
    

function braille_dimensions(s) = [
    (len(str_to_braille(s)) - 2) * CELL_DISTANCE + DOT_DIAMETER + DOT_DISTANCE,
    2 * DOT_DISTANCE + DOT_DIAMETER
    ];

module braille_dot(dot, 2d=false, $fn=$fn) {
    if (dot) {
        if (2d) {
            circle(d=DOT_DIAMETER, $fn=$fn);
        }
        else {
            intersection() {
                sphere(d=DOT_DIAMETER, $fn=$fn);
                translate([-5, -5, 0]) cube(10);
            }
        }
    }
}

module braille(s, $fn=$fn, 2d=false) {
    braille = str_to_braille(s);

    if (len(braille) > 0) {
        for (
            i = [0:(len(braille) - 1)],
                j = [0:2],
                k = [0, 1]
            ) {
            matrix = braille[i];

            translate(
                [
                    i * CELL_DISTANCE + k * DOT_DISTANCE + DOT_DIAMETER / 2,
                    (2 - j) * DOT_DISTANCE + DOT_DIAMETER / 2,
                    0
                    ]) {

                braille_dot(matrix[j][k], $fn=$fn, 2d=2d);
            }
        }
    }
}

DOT_DIAMETER = 1.5;
DOT_DISTANCE = 2.4;
CELL_DISTANCE = 6;


BRAILLE_NUMBER_PREFIX = [
    [[false, true], [false, true], [true, true]]
    ];

BRAILLE_CAPITALIZE_PREFIX = [
    [[false, true], [false, false], [false, true]]
    ];

BRAILLE_UPPERCASE_PREFIX = [
    [[false, true], [false, false], [false, true]],
    [[false, true], [false, false], [false, true]]
    ];

BRAILLE_SPACE = [[false, false], [false, false], [false, false]];

BRAILLE_CHARS = [
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    [[false, true], [true, true], [false, false]],
    [[true, false], [false, false], [false, false]],
    [[true, false], [true, false], [false, false]],
    [[true, true], [false, false], [false, false]],
    [[true, true], [false, true], [false, false]],
    [[true, false], [false, true], [false, false]],
    [[true, true], [true, false], [false, false]],
    [[true, true], [true, true], [false, false]],
    [[true, false], [true, true], [false, false]],
    [[false, true], [true, false], [false, false]],
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    [[true, false], [false, false], [false, false]],
    [[true, false], [true, false], [false, false]],
    [[true, true], [false, false], [false, false]],
    [[true, true], [false, true], [false, false]],
    [[true, false], [false, true], [false, false]],
    [[true, true], [true, false], [false, false]],
    [[true, true], [true, true], [false, false]],
    [[true, false], [true, true], [false, false]],
    [[false, true], [true, false], [false, false]],
    [[false, true], [true, true], [false, false]],
    [[true, false], [false, false], [true, false]],
    [[true, false], [true, false], [true, false]],
    [[true, true], [false, false], [true, false]],
    [[true, true], [false, true], [true, false]],
    [[true, false], [false, true], [true, false]],
    [[true, true], [true, false], [true, false]],
    [[true, true], [true, true], [true, false]],
    [[true, false], [true, true], [true, false]],
    [[false, true], [true, false], [true, false]],
    [[false, true], [true, true], [true, false]],
    [[true, false], [false, false], [true, true]],
    [[true, false], [true, false], [true, true]],
    [[false, true], [true, true], [false, true]],
    [[true, true], [false, false], [true, true]],
    [[true, true], [false, true], [true, true]],
    [[true, false], [false, true], [true, true]],
    undef,
    undef,
    undef,
    undef,
    undef,
    undef,
    [[true, false], [false, false], [false, false]],
    [[true, false], [true, false], [false, false]],
    [[true, true], [false, false], [false, false]],
    [[true, true], [false, true], [false, false]],
    [[true, false], [false, true], [false, false]],
    [[true, true], [true, false], [false, false]],
    [[true, true], [true, true], [false, false]],
    [[true, false], [true, true], [false, false]],
    [[false, true], [true, false], [false, false]],
    [[false, true], [true, true], [false, false]],
    [[true, false], [false, false], [true, false]],
    [[true, false], [true, false], [true, false]],
    [[true, true], [false, false], [true, false]],
    [[true, true], [false, true], [true, false]],
    [[true, false], [false, true], [true, false]],
    [[true, true], [true, false], [true, false]],
    [[true, true], [true, true], [true, false]],
    [[true, false], [true, true], [true, false]],
    [[false, true], [true, false], [true, false]],
    [[false, true], [true, true], [true, false]],
    [[true, false], [false, false], [true, true]],
    [[true, false], [true, false], [true, true]],
    [[false, true], [true, true], [false, true]],
    [[true, true], [false, false], [true, true]],
    [[true, true], [false, true], [true, true]],
    [[true, false], [false, true], [true, true]],
    undef,
    undef,
    undef,
    undef,
    undef
    ];

union() {
    dimensions = braille_dimensions(input_text) + 2 * padding * [1, 1];

    translate([r, r, 0])
    hull() {
        cylinder(r=1);
        translate([dimensions.x - 2*r, 0, 0]) cylinder(r=1);
        translate([0, dimensions.y - 2*r, 0]) cylinder(r=1);
        translate([dimensions.x - 2*r, dimensions.y - 2*r, 0]) cylinder(r=1);
    }

    translate([padding, padding, 1]) {
        braille(input_text);
    }
}
