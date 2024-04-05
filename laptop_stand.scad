$fn = 100;

module base_triangle()
{
    polygon(points = [
        [ 0, 0 ],
        [ 60, 0 ],
        [ 60, 10 ],
        [ 15.3, 70 ],
        [ -15.3, 70 ],
        [ -60, 10 ],
        [ -60, 0 ],
    ]);
}

module soft_base_triangle()
{
    offset(r = 5) offset(r = -5)
    {
        base_triangle();
    }
    polygon(points = [
        [ 60, 0 ],
        [ 60, 5 ],
        [ -60, 5 ],
        [ -60, 0 ],
    ]);
}

module softer_base_triangle()
{
    offset(r = 2) offset(r = -2)
    {
        difference()
        {
            soft_base_triangle();
            // to make round edges at entry of
            // laptop cutout
            polygon(points = [
                [ 5.3, 50 ],
                [ 5.3, 90 ],
                [ -5.3, 90 ],
                [ -5.3, 50 ],
            ]);
        }
    }
}

module laptop_cutout()
{
    polygon(points = [
        [ 5.3, 10 ],
        [ 5.3, 90 ],
        [ -5.3, 90 ],
        [ -5.3, 10 ],
    ]);
}

module outline()
{
    difference()
    {
        softer_base_triangle();
        laptop_cutout();
    }
}

module triangle_cutouts()
{
    offset(r = 3) offset(r = -13)
    {
        outline();
    }
}

module wedge()
{
    polygon(points = [
        [ -5.3, 21 ],
        [ 2.8, 10 ],
        [ -5.3, 10 ],
    ]);
}

module stand()
{
    difference()
    {
        outline();
        triangle_cutouts();
    }
    wedge();
}

linear_extrude(height = 15)
{
    stand();
}