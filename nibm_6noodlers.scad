// Module for nib #6 and Noodlers feeder (or selfmade feeder for nib #6

// Min diameter of outer cylinder around nib module
nibm_module_mind= 4.5*2;
// Height of printed part of nib module
nibm_h= 19;
// Diameter of the cylinder in wich nib goes freely
nibm_nib_d= 9;
// Height of the nib out of the module
nibm_nib_h= 22;

//$fn=200;

module nibm_cut(center= true)
{
    translate([0, 0, center ? - nibm_h/2 : 0])
    union()
    {
        translate([0,0,1])
        union()
        {
            cylinder(r=3.27, h=18.01);
            translate([0,0,3])
            difference()
            {
                cylinder(r=3.58, h=15.01, center=false);
                translate([-5, -1.5, -6])
                rotate([-3,0,0])
                cube([10,10,120], center=false);
            };
        }
        translate([0,0,-0.01])
        union()
        {
            intersection()
            {
                cylinder(r=3.27, h=2, center=false);
                translate([-2,-4,0])
                cube([4,3,2], center=false);
            }
            cylinder(r=2.7, h=2, center= false);
        }
    }
}

module nubm_minimal(center= true)
{
    translate([0, 0, center ? - nibm_h/2 : 0])
    difference()
    {
        cylinder(d= nibm_module_mind, h= nibm_h, center= false);
       nibm_cut(center);
    }
}

//nubm_minimal(center= false);
