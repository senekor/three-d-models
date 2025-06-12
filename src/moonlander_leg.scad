// inspired by:
// https://www.thingiverse.com/thing:4688862

$fn = 100;

screw_radius = 4.6;
leglen = 50;
legwid = screw_radius * 2;
legthick = 7;

module screw_hole() {
  translate([0, 0, 1]) linear_extrude(height=legthick) circle(r=screw_radius);
  translate([0, 0, -1]) linear_extrude(height=legthick) circle(r=2.5);
}

module leg() {
  linear_extrude(height=legthick) circle(r=screw_radius + 1);
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
