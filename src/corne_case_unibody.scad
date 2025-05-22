$fn = 100;

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

module unibody_half() {
  rotate([0, 0, 202]) translate([-136, 0, 0]) kbd_case();
}

module unibody_floor() {
  linear_extrude(height=1.999) offset(r=4) offset(r=-4) polygon(
          [
            [148, 40],
            [148, -65],
            [-148, -65],
            [-148, 40],
          ],
        );
}

unibody_half();
scale([-1, 1, 1]) unibody_half();
unibody_floor();

linear_extrude(height=6) polygon(
    [
      [-68, 38],
      [-68.5, 36],
      [-70.5, 36],
      [-71.5, 34],
      [-85, 40],
      [85, 40],
      [71.5, 34],
      [70.5, 36],
      [68.5, 36],
      [68, 38],
    ],
  );
linear_extrude(height=6) polygon(
    [
      [-32, -63],
      [-35, -65],
      [35, -65],
      [32, -63],
    ],
  );
