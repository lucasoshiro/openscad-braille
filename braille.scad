$fn = 30;

input_text = "Hello world";
generate_plate = true;
padding = 2;
r = 1;

function char_is_number(c) = ord(c) >= ord("0") && ord(c) <= ord("9");

function char_is_uppercase(c) = ord(c) >= ord("A") && ord(c) <= ord("Z");

function is_numeric(s, i=0) = i == len(s) ? true : char_is_number(s[i]) && is_numeric(s, i+1);

function is_uppercase(s, i=0) = i == len(s) ? true : char_is_uppercase(s[i]) && is_uppercase(s, i+1);

function get_braille_prefix(word) =
    len(word) == 0        ? []                        :
    is_numeric(word)      ? BRAILLE_NUMBER_PREFIX     :
    is_uppercase(word[0]) ? BRAILLE_CAPITALIZE_PREFIX :
    is_uppercase(word)    ? BRAILLE_UPPERCASE_PREFIX  :
    [];

function get_braille_char(c) = BRAILLE_CHARS[ord(c)];

function word_to_braille(word) = [for (c = word) get_braille_char(c)];

function append_to_braille(braille, word) = concat(
    braille,
    [BRAILLE_SPACE],
    get_braille_prefix(word),
    word_to_braille(word)
    );

function words_to_braille(words, i=0, braille=[]) =
    i == len(words) ? braille :
    len(braille) == 0 ? words_to_braille(words, i+1, word_to_braille(words[i])) :
    words_to_braille(words, i+1, append_to_braille(braille, words[i]));


function split_words(s, i=0, words=[]) =
    i == len(s) ? words :
    s[i] == " " ? split_words(s, i+1, concat([for (w = words) w], [""])) :
    len(words) == 0 ? split_words(s, i+1, [s[i]]) :
    len(words) == 1 ? split_words(s, i+1, [str(words[0], s[i])]) :
    split_words(
        s,
        i+1,
        concat([for (j=[0:(len(words) - 2)]) words[j]],
               [str(words[len(words)-1], s[i])]
            )
        );

function str_to_braille(s) = words_to_braille(split_words(s));

function braille_dimensions(s) = [
    (len(str_to_braille(s)) - 1) * CELL_DISTANCE + DOT_DIAMETER + DOT_DISTANCE,
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

if (generate_plate) {
    union() {
        dimensions = braille_dimensions(input_text) + 2 * padding * [1, 1];

        color("white") translate([r, r, 0]) hull() {
            cylinder(r=1);
            translate([dimensions.x - 2*r, 0, 0]) cylinder(r=1);
            translate([0, dimensions.y - 2*r, 0]) cylinder(r=1);
            translate([dimensions.x - 2*r, dimensions.y - 2*r, 0]) cylinder(r=1);
        }

        translate([padding, padding, 1]) {
            color("black") braille(input_text);
        }
    }
}
else {
    braille(input_text);
}

/* echo(split_words("um dois tres quatro")); */
