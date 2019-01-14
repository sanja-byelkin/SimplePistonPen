include <threads_w_cut.scad>
// Module for Peter Bock module 250

// Min diameter of outer cylinder around nib module
nibm_module_mind= 8+0.2+0.4*4;
// Height of printed part of nib module
nibm_h= 24;
// Diameter of the cylinder in wich nib goes freely
nibm_nib_d= 9;
// Height of the nib out of the module
nibm_nib_h= 17;

//$fn=200;
nibm_tollerance=0.4;

module nibm_cut(center= true)
{
    translate([0, 0, center ? - nibm_h/2 : 0])
    union()
    {
        translate([0,0,nibm_h-0.5 - 0.01])
        cylinder(d2=8.6+nibm_tollerance, d1=8+nibm_tollerance, h=0.5+0.02);
        translate([0,0,nibm_h- 18.3 - 0.01])
        cylinder(d=8+nibm_tollerance, h=18.3-0.5+0.02);
        translate([0,0, nibm_h- 18.3 -4 -0.01])
        metric_thread_w_entry (diameter= 8 +nibm_tollerance, pitch= 0.65, length= 4 + 0.02, internal=true, cut_bottom=true, cut_top=false);
         hh= (8-6.6)*2/3;
         translate([0,0, nibm_h- 18.3 -4 -0.01 - hh- 0.01])
            cylinder(d1=6.6+nibm_tollerance, d2= 8 +nibm_tollerance, h= hh + 0.02);
            translate([0,0, -0.01])
           cylinder(d=6.6+nibm_tollerance, h= nibm_h -18.3 -4 - hh +0.02);
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

//nibm_cut(center= false);
//nubm_minimal(center= false);
