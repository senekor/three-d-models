$fn = 100;

module corner(o) {
  translate([110 + o, 20 + o, 0]) sphere(r=1.5);
}
module corner_1(o) {
  scale([1, 1, 1]) corner(o);
}
module corner_2(o) {
  scale([-1, 1, 1]) corner(o);
}
module corner_3(o) {
  scale([1, -1, 1]) corner(o);
}
module corner_4(o) {
  scale([-1, -1, 1]) corner(o);
}

module edge_1(o) {
  hull() {
    corner_1(o);
    corner_2(o);
  }
}
module edge_2(o) {
  hull() {
    corner_2(o);
    corner_4(o);
  }
}
module edge_3(o) {
  hull() {
    corner_4(o);
    corner_3(o);
  }
}
module edge_4(o) {
  hull() {
    corner_3(o);
    corner_1(o);
  }
}
module edges(o) {
  edge_1(o);
  edge_2(o);
  edge_3(o);
  edge_4(o);
}

module floor() {
  hull() {
    edges(0);
  }
}

module walls() {
  hull() {
    edge_1(0);
    translate([0, 0, 5]) edge_1(3);
  }
  hull() {
    edge_2(0);
    translate([0, 0, 5]) edge_2(3);
  }
  hull() {
    edge_3(0);
    translate([0, 0, 5]) edge_3(3);
  }
  hull() {
    edge_4(0);
    translate([0, 0, 5]) edge_4(3);
  }
}

module plate() {
  floor();
  walls();
}

module fork() {
  rotate(90, [0, 0, 1]) rotate(90, [1, 0, 0]) linear_extrude(height=0.01, center=false) difference() {
          square(size=[17, 70], center=true);
          translate([0, 20, 0]) circle(r=20);
        }
}

module fancy_fork() {
  minkowski() {
    fork();
    sphere(r=1.5);
  }
}

module round_half_edge_thingy(outset) {
  translate([0, 8.5, 1.5]) rotate_extrude(angle=180, convexity=2) translate([1.5 + outset, 0, 0]) circle(r=1.5);
}

module chamfer_shape(outset) {
  hull() {
    translate([1.5 + outset, 8.5, 1.5]) sphere(1.5);
    translate([1.5 + outset, -8.5, 1.5]) sphere(1.5);
  }
  hull() {
    translate([-1.5 - outset, 8.5, 1.5]) sphere(1.5);
    translate([-1.5 - outset, -8.5, 1.5]) sphere(1.5);
  }
  round_half_edge_thingy(outset);
  scale([1, -1, 1]) round_half_edge_thingy(outset);
}

module fork_chamfer() {
  difference() {
    translate([0, 0, 0]) chamfer_shape(0);
    translate([0, 0, 1.5]) chamfer_shape(1.5);
  }
}

module stand() {
  difference() {
    union() {
      plate();
      translate([60, 0, 15]) fancy_fork();
      translate([60, 0, 0]) fork_chamfer();
      translate([-60, 0, 5]) fancy_fork();
      translate([-60, 0, 0]) fork_chamfer();
    }
    translate([0, 0, -150]) cube(300, center=true);
  }
}

stand();
