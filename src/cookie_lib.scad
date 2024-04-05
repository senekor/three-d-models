module cookie_cutter() {
    difference() {
        linear_extrude(height = 15) {
            minkowski() {
                children();
                circle(r = 2);
            }
        }
        translate(v = [0,0,1]) 
        linear_extrude(height = 15) {
            children();
        } 
    }
}
