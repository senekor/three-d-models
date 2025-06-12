$fn = 100;

screw_radius = 4.6;
leglen = 50;
legthick = 7;

insert_thick = sqrt((legthick / 2) * (legthick / 2) * 2);
insert_len = legthick;

module screw_hole() {
  translate([0, 0, 1]) linear_extrude(height=legthick) circle(r=screw_radius);
  translate([0, 0, -1]) linear_extrude(height=legthick) circle(r=2.5);
}

module insert() {
  // intersection() {
  rotate([45, 0, 0]) cube([insert_len * 2, insert_thick, insert_thick], center=true);
  //   cube([insert_len * 3, legthick, legthick], center=true);
  // }
}

module leg() {
  difference() {
    union() {
      linear_extrude(height=legthick) circle(r=screw_radius + 1);
      union() {
        translate([0, -legthick / 2, 0]) cube([leglen - insert_len, legthick, legthick]);
        translate([leglen - insert_len, 0, legthick / 2]) insert();
      }
    }
    screw_hole();
  }
}

footthick = sqrt(legthick * legthick * 2);

module foot_sphere() {
  sphere(r=footthick * 0.7);
}

module foot() {
  footlen = 40;
  difference() {
    intersection() {
      //                   This number is eyeballed.
      //                           v
      translate([0, footthick / 2, 2]) hull() {
          translate([0, 0, 0]) foot_sphere();
          translate([footlen, 0, 0]) foot_sphere();
        }
      cube([footlen, footthick, footthick * 2]);
    }
    translate([footthick / 2, footthick / 2, insert_len - 1]) rotate([45, 90, 0]) insert();
  }
}

leg();
translate([0, -20, 0]) foot();
