module lid_base()
{
    // scale 110% in x and y
    // should be about +4ms on each side
    scale([ 1.1, 1.1, 1 ])
    {
        linear_extrude(height = 4)
        {
            children();
        }
    }
}

module lid_wedge()
{
    difference()
    {
        linear_extrude(height = 5, scale = 0.95)
        {
            children();
        }
        translate([ 0, 0, -1 ])
        {
            linear_extrude(height = 7, scale = 1.3)
            {
                scale([ 0.7, 0.7, 1 ]) children();
            }
        }
    }
}

module yogurt_lid()
{
    scale([ 1, 1, -1 ]) lid_base() children();
    lid_wedge() children();
}