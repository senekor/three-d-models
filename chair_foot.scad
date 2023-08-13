module chair_foot()
{
    scale([ 1, 1, -1 ]) cylinder(h = 4, r = 20);
    difference()
    {
        cylinder(h = 8, r = 15.5);
        cylinder(h = 30, r = 12, center = true);
    }
}

chair_foot();