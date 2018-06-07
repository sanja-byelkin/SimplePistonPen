include <threads_w_cut.scad>

nibm_module_mind= 4.5*2;
nibm_top_h= 7;
nibm_thread_h=7;
nibm_bottom_h=4;
nibm_h= nibm_top_h + nibm_bottom_h + nibm_thread_h;
nibm_nib_d= 7.4;
nibm_nib_h= 23;

module nibm_cut(center= true)
{
    translate([0, 0, center ? - nibm_h/2 : 0])
    union()
    {
        translate([0, 0, nibm_bottom_h + nibm_thread_h - 0.01])
        cylinder(r=3.7, h= nibm_top_h + 1.01, center= false);
        translate([0, 0, nibm_bottom_h])
        metric_thread_w_entry (diameter= 7.2, pitch= 0.75, length= nibm_thread_h, internal=true, cut_bottom=true, cut_top=true);
        translate([0, 0, -1])
        cylinder(r=3.5, h= nibm_bottom_h + 1.01, center= false);
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