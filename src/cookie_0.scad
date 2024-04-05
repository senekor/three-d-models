include <cookie_lib.scad>

module o() {
    scale(v = [0.7,1,1])
    // (10cm / 2) - minkowski circle radius
    circle(r = 39);
}

module ring() {
    minkowski() {
        difference() {
            o();
            scale(v = [0.999,0.999,1]) {
                o();
            }
        }
        circle(r = 9);
    }
}

cookie_cutter() {
    ring();
}
