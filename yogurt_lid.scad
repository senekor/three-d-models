$fn = 100;

module halb_viertel_becher_innenumfang()
{

    polygon(points = [
        [ 0, 0 ],
        [ 39, 0 ],
        [ 38.2, 08 ],
        [ 37, 19 ],
        [ 36, 26.5 ],
        [ 35, 30 ],
        [ 33, 33 ],
        [ 31, 35 ],
        [ 27, 37 ],
        [ 21, 38 ],
        [ 16, 38.4 ],
        [ 11, 38.7 ],
        [ 6, 38.9 ],
        [ 0, 39 ],
    ]);
}

module viertel_becher_innenumfang()
{
    mirror([ 1, -1 ])
    {
        halb_viertel_becher_innenumfang();
    }
    halb_viertel_becher_innenumfang();
}

module becher_innenumfang()
{
    rotate(a = 0) viertel_becher_innenumfang();
    rotate(a = 90) viertel_becher_innenumfang();
    rotate(a = 180) viertel_becher_innenumfang();
    rotate(a = 270) viertel_becher_innenumfang();
}

module lid_base()
{
    // scale 110% in x and y
    // should be about +4ms on each side
    scale([ 1.1, 1.1, 1 ])
    {
        linear_extrude(height = 4)
        {
            becher_innenumfang();
        }
    }
}

module lid_wedge()
{
    difference()
    {
        linear_extrude(height = 5, scale = 0.95)
        {
            becher_innenumfang();
        }
        translate([ 0, 0, -1 ])
        {
            linear_extrude(height = 7, scale = 1.3)
            {
                scale([ 0.7, 0.7, 1 ]) becher_innenumfang();
            }
        }
    }
}

module yogurt_lid()
{
    scale([ 1, 1, -1 ]) lid_base();
    lid_wedge();
}

yogurt_lid();