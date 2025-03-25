$fn = 100;

l = 30;
h = 3;

module squares(skip)
{
    for (i = [0:1:7])
    {
        for (k = [0:1:7])
        {
            if ((i + k) % 2 != skip)
            {
                translate([ l * (i - 4), l * (k - 4), 0 ]) square(30);
            }
        }
    }
}

module outline()
{
    square(l * 8, center = true);
}

module king_marker(white)
{
    direction = white ? -1 : 1;
    angle = white ? 0 : 180;
    translate([ l / 2 + (5 * direction), l * 3.7 * direction, 0 ]) rotate(angle) text("K");
}

module white()
{
    color("white") linear_extrude(h)
    {
        difference()
        {
            squares(skip = 0);
            king_marker(white = false);
        }
        king_marker(white = true);

        difference()
        {
            offset(delta = 2) outline();
            outline();
        }
    }
}
module orange()
{
    color("orange") linear_extrude(h)
    {
        difference()
        {
            squares(skip = 1);
            king_marker(white = true);
        }
        king_marker(white = false);

        difference()
        {
            offset(7) outline();
            offset(delta = 2) outline();
        }
    }
}

// Comment out one or the other to produce two separate STL files.
// These can be loaded separately in the slicer to apply different colors.
white();
orange();
