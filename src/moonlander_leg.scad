// inspired by:
// https://www.thingiverse.com/thing:4688862

$fn = 100;

leglen = 40;
legwid = 7;
legthick = 5;

module screw_hole() {
  translate([0, 0, 1]) linear_extrude(height=legthick) circle(r=5);
  translate([0, 0, -1]) linear_extrude(height=legthick) circle(r=2.5);
}

module leg() {
  linear_extrude(height=legthick) circle(r=6);
  linear_extrude(height=legthick) translate([leglen / 2, 0, 0]) square(size=[leglen, legwid], center=true);
}

module foot_sphere() {
  sphere(r=legthick * 0.7);
}

module foot() {
  footwid = legwid;
  intersection() {
    hull() {
      translate([0, -footwid / 2, 0]) foot_sphere();
      translate([0, footwid / 2, 0]) foot_sphere();
    }
    cube([legthick * 2, footwid, legthick], center=true);
  }
}

difference() {
  leg();
  screw_hole();
}
translate([leglen, 0, legthick / 2]) foot();
