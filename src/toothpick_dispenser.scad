$fn = 100;

total_height = 100;
base_height = 20;

module outer_wall(height) {
  linear_extrude(height) square([45, 27], center=true);
}

module inner_wall(height) {
  linear_extrude(height) square([45, 23], center=true);
}

module pillar(height, connect_right) {
  translate([17.5, 0, 0]) linear_extrude(height) square([10, 9], center=true);
  translate([21.5, connect_right ? -8 : 8, 0]) linear_extrude(height) square([2, 10], center=true);
}

module magazine(height) {
  difference() {
    outer_wall(height);
    translate([2, 0, 1]) inner_wall(height);
  }
  pillar(height - 3.5, true);
}

module base_outer_wall(height) {
  linear_extrude(height) square([49.3, 31.3], center=true);
}

module base_inner_wall(height) {
  linear_extrude(height) square([45.3, 27.3], center=true);
}

module base_cutout() {
  translate([0, 0, 0]) base_inner_wall(30);
  translate([5, 0, 0]) linear_extrude(30) square([45, 23], center=true);
}

module base(height) {
  rail_height = 5;
  difference() {
    base_outer_wall(height + rail_height);
    translate([0, 0, height]) base_cutout();
  }
}

translate([0, 35, 0]) magazine(total_height - base_height);
base(base_height);
