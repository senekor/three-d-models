include <cookie_lib.scad>

module o() {
    scale(v = [0.7,1,1])
    // 85 because the final height should be 10cm,
    // and minkowski adds 15mm.
    circle(r = 85);
}

module ring() {
    minkowski() {
        difference() {
            o();
            scale(v = [0.99,0.99,1]) {
                o();
            }
        }
        circle(r = 15);
    }
}

cookie_cutter() {
    ring();
}
