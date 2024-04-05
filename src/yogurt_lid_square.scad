include <yogurt_lid_lib.scad>

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

yogurt_lid() becher_innenumfang();