include <slices.scad>

module rough_handle_spiral (d=5, h=7, rough=1)
{
    slc= round(360 / (asin(rough/(d)) * 2 * 3));
    pitch= slc*3;
    dh= (rough*1.5)*sqrt(3)/2;
    linear_extrude(height= h, center= false, convexity=4 , twist= h/pitch*360 ,slices= h/pitch*slices(d/2))
    for (s= [0:slc-1])
    {
        rotate(s*360/slc)
        polygon([[d/2-rough,0], [d/2+dh-rough, (rough*1.5)/2], [d/2+dh-rough, -(rough*1.5)/2]]);
    }
}

module rough_handle (d=5, h=7, rough= 0.5)
{
    translate([0, 0, -h/2])
    difference()
    {
        cylinder(d=d, h= h, center= false);
        translate([0,0,-1])
        union()
        {
            rough_handle_spiral(d, h+2, rough);
            mirror([0,1,0])
            rough_handle_spiral(d, h+2, rough);
        };
    }
}

