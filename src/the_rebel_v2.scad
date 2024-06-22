// laptop measurements
BODY_WIDTH = 10.5;

// angle for center of mass
ANGLE = 30;

module body_ramp()
{
   rotate([ ANGLE, 0, 0 ]) translate([ -BODY_WIDTH-1, 0, -100 ]) cube([ BODY_WIDTH*2+2, 100, 100 ]);
}

module screen_ramp()
{
    rotate([ ANGLE, 0, 0 ]) translate([ -BODY_WIDTH-1, -100, 0 ]) cube([ BODY_WIDTH*2+2, 100, 100 ]);
}

module rail()
{
    difference()
    {
        rotate([ ANGLE, 0, 0 ]) translate([ BODY_WIDTH+1, 0, -98 ]) cube([ 2, 100, 100 ]);
        cube([ 30, 5, 20 ], center = true);
    }
}

module outer_dims()
{
    translate([-15,0,0]) rotate([ 90, 0, 90 ]) linear_extrude(30) polygon(points = [
        [ -50, 0 ], [ 50, 0 ], [ 0, 170 ], // 170mm = height of center of mass, somehow this feels right.
    ]);
}

module wall()
{
    intersection()
    {
        // 49.355 is visually fine-tuned to match with the top of body_ramp.
        cube([ 2, 200, 49.355 ], center = true);
        translate([ -10, 0, 0 ]) outer_dims();
    }
}

module the_rebel()
{
    intersection()
    {
        union()
        {
            body_ramp();
            screen_ramp();
            rail();
            scale([-1,1,1]) rail();
            wall();
        }
        outer_dims();
    }
}

the_rebel();
