module chair_foot()
{
    translate([ 0, 0, -3 ]) cylinder(h = 3, r = 20);
    difference()
    {
        cylinder(h = 8, r = 15.5);
        cylinder(h = 30, r = 12, center = true);
    }
}

chair_foot();