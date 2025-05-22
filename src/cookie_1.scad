include <cookie_lib.scad>

module i() {
  minkowski() {
    polygon(
      points=[
        [08, 38],
        [16, 38],
        [16, 45],
        [-16, 45],
        [-16, 38],
        [-08, 38],
        [-08, -38],
        [-16, -38],
        [-16, -45],
        [16, -45],
        [16, -38],
        [08, -38],
      ],
    );
    circle(r=5);
  }
}

cookie_cutter() {
  i();
}
