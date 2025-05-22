module pcb_outline() {
  polygon(
    points=[
      [0, 0],
      [0, 57],
      [56, 57],
      [67, 71.5],
      [104.325, 77],
      [120, 86.1],
      [134.325, 60.7],
      [134.325, 0],
      [113.67, 0],
      [113.67, -2],
      [94.67, -2],
      [94.67, -4.5],
      [75.67, -4.5],
      [75.67, -6.7],
      [57.525, -6.7],
      [57.525, -4.5],
      [38.425, -4.5],
      [38.425, 0],
    ],
  );
}

module center_pcb_outline() {
  translate([-70, -30, 0]) {
    children();
  }
}

module inner() {
  translate([0, 0, 2]) {
    linear_extrude(height=8) {
      pcb_outline();
    }
  }
}

module outer() {
  minkowski() {
    linear_extrude(height=6) {
      pcb_outline();
    }
    // I don't want to add any height,
    // but it must be non-zero to work.
    cylinder(h=0.00001, r=2);
  }
}

module cutout() {
  translate([0, 0, 2]) {
    linear_extrude(10) {
      square(size=10);
    }
  }
}

module trrs_cutout() {
  translate([134, 42.5, 0]) {
    cutout();
  }
}

module usb_cutout() {
  translate([118, -9, 0]) {
    translate([0, 0, 2]) {
      linear_extrude(10) {
        square(size=14);
      }
    }
  }
}

module kbd_case() {
  difference() {
    outer();
    inner();
    trrs_cutout();
    usb_cutout();
  }
}

center_pcb_outline() kbd_case();
