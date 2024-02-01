use <braille.scad>

$fn = 30;

union() {
    cube([71, 9, 1]);

    translate([0, 1, 1]) {
        braille("Hello world");
    }
}
