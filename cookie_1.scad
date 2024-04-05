include <cookie_lib.scad>

module i() {
    minkowski() {
        polygon(points = [
            [ 10, 45 ],
            [ -10, 45 ],
            [ -10, -45 ],
            [ 10, -45 ],
        ]);
        circle(r = 5);
    }
}

cookie_cutter() {
    i();
}
