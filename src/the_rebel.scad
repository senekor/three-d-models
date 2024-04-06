$fn = 100;

FLOOR_W = 80;
FLOOR_H = 60;

RAIL_HEIGHT = 4;
RAIL_THICK = 3;
RAIL_THICK_HALF = RAIL_THICK / 2;

// laptop measurements
THIN_W = 5;
BROAD_W = 10.5;

ANGLE = 20;
// broad range offset depends on angle, adjust accordingly
BR_OFFSET = 3.65;

module floor_outline()
{
    offset(r = RAIL_THICK_HALF) offset(r = -RAIL_THICK_HALF)
    {
        square([ FLOOR_W, FLOOR_H ]);
    }
}

module floor()
{
    translate(v = [ 0, 0, -2 ]) linear_extrude(height = 2) floor_outline();
}

// floor();

module rail_sphere()
{
    sphere(r = RAIL_THICK_HALF);
}

module rail(length)
{
    translate([ RAIL_THICK_HALF, RAIL_THICK_HALF, 0 ]) hull()
    {
        rail_sphere();
        translate([ length - RAIL_THICK, 0, 0 ]) rail_sphere();
    }
    scale([ 1, 1, -1 ])
    {
        linear_extrude(height = 30) translate([ RAIL_THICK_HALF, RAIL_THICK_HALF, 0 ]) hull()
        {
            translate(v = [ 0, 0, 0 ]) circle(r = RAIL_THICK_HALF);
            translate(v = [ length - RAIL_THICK, 0, 0 ]) circle(r = RAIL_THICK_HALF);
        }
    }
}

// rail(10);

module thin_rail_short()
{
    translate([ RAIL_THICK + BROAD_W, RAIL_THICK + THIN_W, 0 ]) rail(FLOOR_W - RAIL_THICK * 2 - BROAD_W * 2);
}

// thin_rail_short();

module thin_rail_long()
{
    rail(FLOOR_W);
}

// thin_rail_long();

module broad_rail()
{
    translate([ RAIL_THICK, RAIL_THICK + THIN_W, 0 ]) rotate(90, [ 0, 0, 1 ])
        rail(FLOOR_H - RAIL_THICK - THIN_W - BR_OFFSET);
}

// broad_rail();

module broad_rail_pair()
{
    broad_rail();
    translate(v = [ BROAD_W + RAIL_THICK, 0, 0 ]) broad_rail();
}

module ramp_floor()
{
    translate([ 0, 0, -RAIL_HEIGHT ]) hull() broad_rail_pair();
}

module ramp()
{
    union()
    {
        broad_rail_pair();
        ramp_floor();
    }
}

// ramp();

module thin_rail_floor()
{
    translate([ RAIL_THICK_HALF, RAIL_THICK_HALF, 0 ]) hull()
    {
        translate([ 0, 0, 0 ]) rail_sphere();
        translate([ 0, RAIL_THICK + THIN_W, 0 ]) rail_sphere();
        translate([ FLOOR_W - RAIL_THICK, 0, 0 ]) rail_sphere();
        translate([ FLOOR_W - RAIL_THICK, RAIL_THICK + THIN_W, 0 ]) rail_sphere();
    }
}

module all_rails()
{
    translate([ 0, 0, RAIL_HEIGHT ])
    {
        thin_rail_long();
        thin_rail_short();
        ramp();
        translate([ FLOOR_W - BROAD_W - RAIL_THICK * 2, 0, 0 ]) ramp();
    }
    hull()
    {
        thin_rail_floor();
        translate(v = [ 0, 0, -10 ]) thin_rail_floor();
    }
}

// for testing rail dimensions, print this smaller piece
// difference()
// {
//     all_rails();
//     translate([ -1, -1, -100.4 ]) cube([ 100, 100, 100 ]);
// }

module tilted_rails()
{
    difference()
    {
        rotate(a = ANGLE, v = [ 1, 0, 0 ]) all_rails();
        // .001 for overlap with floor, so openscad nicely detects connection
        translate([ -5, -5, -30.001 ]) cube([ FLOOR_W + 10, FLOOR_H + 20, 30 ]);
    }
}

// tilted_rails();

module the_rebel()
{
    translate([ -(FLOOR_W / 2), -(FLOOR_H / 2), 0 ])
    {
        tilted_rails();
        floor();
    }
}

the_rebel();
