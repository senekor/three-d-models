$fn = 100;

FLOOR_W = 80;
FLOOR_H = 60;

ANGLE = 20;
// broad range offset depends on angle, adjust accordingly
BR_OFFSET = 3.65;

RAIL_HEIGHT = 4;

module floor_outline()
{
    offset(r = 1.5) offset(r = -1.5)
    {
        square([ FLOOR_W, FLOOR_H ]);
    }
}

module floor()
{
    translate(v = [ 0, 0, -2 ]) linear_extrude(height = 2) floor_outline();
}

// floor();

module thin_rail_outline()
{
    translate(v = [ 1.5, 1.5 ]) hull()
    {
        translate(v = [ 10 + 3, 0, 0 ]) circle(r = 1.5);
        translate(v = [ FLOOR_W - 3 - 10 - 3, 0, 0 ]) circle(r = 1.5);
    }
}

module thin_rail()
{
    scale([ 1, 1, -1 ])
    {
        linear_extrude(height = 10) thin_rail_outline();
        hull()
        {
            translate(v = [ 1.5 + 10 + 3, 1.5, 0 ]) sphere(r = 1.5);
            translate(v = [ FLOOR_W - 1.5 - 10 - 3, 1.5, 0 ]) sphere(r = 1.5);
        }
    }
}

// thin_rail();

module thin_rail_outline_long()
{
    translate(v = [ 1.5, 1.5 ]) hull()
    {
        translate(v = [ 0, 0, 0 ]) circle(r = 1.5);
        translate(v = [ FLOOR_W - 3, 0, 0 ]) circle(r = 1.5);
    }
}

module thin_rail_long()
{
    scale([ 1, 1, -1 ])
    {
        linear_extrude(height = 10) thin_rail_outline_long();
        hull()
        {
            translate(v = [ 1.5, 1.5, 0 ]) sphere(r = 1.5);
            translate(v = [ FLOOR_W - 1.5, 1.5, 0 ]) sphere(r = 1.5);
        }
    }
}

// thin_rail();

module broad_rail_outline()
{
    translate(v = [ 1.5, 1.5 ]) hull()
    {
        translate(v = [ 0, 5 + 3, 0 ]) circle(r = 1.5);
        translate(v = [ 0, FLOOR_H - 3 - BR_OFFSET, 0 ]) circle(r = 1.5);
    }
}

module broad_rail()
{
    scale([ 1, 1, -1 ])
    {
        linear_extrude(height = 30) broad_rail_outline();
        hull()
        {
            translate(v = [ 1.5, 1.5 + 5 + 3, 0 ]) sphere(r = 1.5);
            translate(v = [ 1.5, FLOOR_H - 1.5 - BR_OFFSET, 0 ]) sphere(r = 1.5);
        }
    }
}

// broad_rail();

module broad_rail_pair()
{
    broad_rail();
    translate(v = [ 10 + 3, 0, 0 ]) broad_rail();
}

module ramp_floor()
{
    translate([ 0, 0, -RAIL_HEIGHT ]) hull() broad_rail_pair();
}

module ramp()
{
    difference()
    {
        union()
        {
            broad_rail_pair();
            ramp_floor();
        }
        // translate([ 0, FLOOR_H - 1.5, 0 ]) rotate(a = -ANGLE, v = [ 1, 0, 0 ]) difference()
        // {
        //     translate([ -1, 0, -40 ]) cube([ 18, 30, 40 ]);
        //     hull()
        //     {
        //         translate([ 1.5, 0, 10 ]) sphere(r = 1.5);
        //         translate([ 1.5, 0, -35 ]) sphere(r = 1.5);
        //         translate([ 14.5, 0, 10 ]) sphere(r = 1.5);
        //         translate([ 14.5, 0, -35 ]) sphere(r = 1.5);
        //     }
        // }
    }
}

// ramp();

module thin_rail_floor()
{
    hull()
    {
        translate([ 1.5, 1.5, 0 ]) sphere(r = 1.5);
        translate([ 1.5, 1.5 + 5 + 3, 0 ]) sphere(r = 1.5);
        translate([ FLOOR_W - 1.5, 1.5, 0 ]) sphere(r = 1.5);
        translate([ FLOOR_W - 1.5, 1.5 + 5 + 3, 0 ]) sphere(r = 1.5);
    }
}

module all_rails()
{
    translate([ 0, 0, RAIL_HEIGHT ])
    {
        thin_rail_long();
        translate(v = [ 0, 3 + 5, 0 ]) thin_rail();
        // broad_rail();
        // translate(v = [ 3 + 10, 0, 0 ]) broad_rail();
        // translate(v = [ FLOOR_W - 3, 0, 0 ]) broad_rail();
        // translate(v = [ FLOOR_W - 3 - 10 - 3, 0, 0 ]) broad_rail();
        ramp();
        translate([ FLOOR_W - 16, 0, 0 ]) ramp();
    }
    hull()
    {
        thin_rail_floor();
        translate(v = [ 0, 0, -10 ]) thin_rail_floor();
    }
}

// all_rails();

module tilted_rails()
{
    difference()
    {
        rotate(a = ANGLE, v = [ 1, 0, 0 ]) all_rails();
        translate([ -5, -5, -30.001 ]) cube([ FLOOR_W + 10, FLOOR_H + 20, 30 ]);
    }
}

module the_rebel()
{
    translate([ -(FLOOR_W/2), -(FLOOR_H/2), 0 ])
    {
        tilted_rails();
        floor();
    }
}

the_rebel();
