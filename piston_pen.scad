include <threads_w_cut.scad>
include <slices.scad>
include <push_pull_mechanics.scad>
include <rough_handle.scad>

// Which nib to use
include <nibm_6noodlers.scad>

//include <draft_view.scad>
include <fine_view.scad>
pp_show_assemble= false;
pp_show_back1=true;
pp_show_back2=true;
pp_show_piston=true;
pp_show_screw=true;
pp_show_print_helper=false;
pp_show_pins=true;
pp_show_body=true;
pp_show_cup1=true;
pp_show_cup2=true;

// diameter to fit all mechanisms
pp_d= 9;
// working length of the screw (and piston)
pp_screw_h= 20;
// "nonworking" part os the screw
pp_overlap_h= 4;
// gap between surfaces 
pp_tollerance= 0.3;
pp_tread_d_tollerance= 0.4;
// how much more internal thread to do
pp_internal_thread_h_ratio= 1.2;
// thick enough wall (2 layers)
pp_min_wall= 0.7;
// screw pitch
pp_pitch= 7;
// number of rails * 2
pp_rail_num=2;
// number of screw rails  *2
pp_screw_num=2;
// Orings paremeters used in the piston
pp_oring_inner_d=6.2;
pp_oring_num=2;
pp_oring_d=2;

pp_back_tread_pitch=1;
pp_back_thread1=5;
pp_back_thread2=4;
pp_external_belt=3;
pp_external_belt_d= pp_d + pp_back_tread_pitch*1.18 + pp_min_wall*2 + pp_tread_d_tollerance;
pp_back_back_h= pp_min_wall;

pp_screw_handle_d=7;
pp_screw_handle_h=7;
pp_screw_handle_rough=0.3;

// step enough to hold some load (rail, screw, etc.)
pp_holding_step= pp_min_wall * 1.5;

// borders of screw holder
pp_back_borders= pp_holding_step;
// screw_holder pin parameters
pp_back_holder_pin_h= pp_back_borders*2;
pp_back_holder_pin_w= pp_back_borders;

// Borders in piston
pp_piston_borders= pp_holding_step;

// Body Parameters
pp_body_thread_starts=4;
pp_body_thread_h=3;
pp_boby_thread_pitch=0.75;
pp_body_thread_size=1;
pp_body_thread_interval= 0.1;

// Cup Parameters
pp_cup_after_thread= 30;
pp_cup_thread_pitch= 1;
pp_cup_thread_h= 7;
// Parameters of the clip
pp_clip_gap=1;
pp_clip_width= 4;
pp_clip_thickness= 3;


// Diameters ofouter/inner "cylinders" of piston mechanisms parts
pp_d1_1= pp_d - pp_tollerance*2;
pp_d1_2= pp_d1_1 - (pp_min_wall * 2 + pp_holding_step);
pp_d2_1= pp_d1_2 - pp_tollerance*2;
pp_d2_2= pp_d2_1 - (pp_min_wall * 2 + pp_holding_step );
pp_d3= pp_d2_2 - pp_tollerance * 2;

pp_holder_border_d= pp_d3 + pp_back_holder_pin_w*2 + pp_tollerance*2;

pp_belt_with_thread= max(pp_back_thread1, pp_back_borders*2 + pp_back_holder_pin_h + pp_tollerance*2);
pp_belt_with_thread_top= pp_belt_with_thread - pp_back_thread1;
pp_belt_with_thread_bottom= pp_belt_with_thread - (pp_back_borders*2 + pp_back_holder_pin_h + pp_tollerance*2);

// 0.5 + 1 + o-rings + 1 + 0.5
pp_piston_head_h=pp_piston_borders*3 + pp_oring_num*pp_oring_d;
pp_body_length= pp_screw_h*2 + pp_piston_head_h +   pp_back_thread1 * pp_internal_thread_h_ratio + nibm_h;

pp_cup_d2= pp_external_belt_d + pp_boby_thread_pitch*1.18 + pp_tollerance*2;
pp_cup_d1= pp_cup_d2 + 2 * pp_min_wall;
pp_cup_wide_part_h= pp_cup_after_thread + pp_body_thread_size + pp_body_thread_interval + pp_min_wall ;
pp_cup_narrow_part_d= nibm_nib_d + pp_min_wall * 2;
pp_gap= pp_cup_d1 + 1;

echo("D:", pp_d1_1, pp_d1_2, pp_d2_1, pp_d2_2, pp_d3);
echo("Belt:", pp_belt_with_thread_top, pp_belt_with_thread, pp_belt_with_thread_bottom);
echo("Body length:", pp_body_length);

// Back1
if (pp_show_back1)
translate ([pp_show_assemble ? 0 : pp_gap, pp_show_assemble ? 0 : pp_gap, - pp_back_back_h - pp_screw_handle_h - pp_tollerance - pp_back_thread2*pp_internal_thread_h_ratio - pp_back_thread1 - pp_external_belt - (pp_screw_h + pp_overlap_h)/2])
union(){
    cylinder(d= pp_external_belt_d, h= pp_back_back_h);
    difference()
    {
        translate([0, 0, pp_back_back_h - 0.01])
        cylinder(d= pp_external_belt_d, h= pp_screw_handle_h + pp_tollerance + pp_back_thread2*pp_internal_thread_h_ratio + 0.01, center= false);
        union()
        {
            translate([0, 0, pp_back_back_h - 0.01])
            cylinder(d=pp_screw_handle_d + 2 * pp_tollerance, h= pp_screw_handle_h + pp_tollerance + 0.02, center=false);
            translate([0, 0, pp_back_back_h + pp_screw_handle_h + pp_tollerance])
            metric_thread_w_entry (diameter=pp_d1_1+ pp_back_tread_pitch*1.18 + pp_tread_d_tollerance, pitch=pp_back_tread_pitch, length= pp_back_thread2*pp_internal_thread_h_ratio + 0.01, internal= true, cut_top=true, cut_bottom=false);
        }
    }
}

// Back2
if (pp_show_back2)
translate ([pp_show_assemble ? 0 : pp_gap, 0, 0])
union(){
    // Piston holder
    difference(){
        cylinder(d=pp_d1_1, h= pp_screw_h + pp_overlap_h, center=true);
        rails(d1 = pp_d1_2 + pp_holding_step, d2= pp_d1_2, ratio=0.5, h= pp_screw_h + pp_overlap_h + 2, num= pp_rail_num);
    };
    // Screw holder
    difference(){
        union()
        {
            if (pp_belt_with_thread_top)
              translate([0, 0, - pp_belt_with_thread_top/2 - (pp_screw_h + pp_overlap_h)/2])
              cylinder(d= pp_d1_1, h= pp_belt_with_thread_top, center=true);
            // upper thread
            translate([0, 0, -pp_back_thread1 - (pp_screw_h + pp_overlap_h)/2])
            metric_thread_w_entry (diameter=pp_d1_1+ pp_back_tread_pitch*1.18, pitch=pp_back_tread_pitch, length= pp_back_thread1, , cut_top=true, cut_bottom= false);
            // belt
            translate([0, 0, -pp_back_thread1 - pp_external_belt - (pp_screw_h + pp_overlap_h)/2])
            cylinder(d= pp_external_belt_d, h= pp_external_belt, center= false);
            //lower thread
            translate([0, 0, - pp_back_thread2 - pp_back_thread1 - pp_external_belt - (pp_screw_h + pp_overlap_h)/2])
            metric_thread_w_entry (diameter=pp_d1_1+ pp_back_tread_pitch*1.18, pitch=pp_back_tread_pitch, length= pp_back_thread2, cut_top=false, cut_bottom=true);
        }
        translate([0, 0, - 1 - pp_belt_with_thread - pp_external_belt - pp_back_thread2 - (pp_screw_h + pp_overlap_h)/2])
        cylinder(d=pp_holder_border_d + pp_tollerance*2, h= pp_belt_with_thread + pp_external_belt + pp_back_thread2 + 2, center= false);
        // Pin's hole
        translate([pp_holder_border_d/2 -  pp_back_holder_pin_w/2 + pp_tollerance, 0, - pp_back_holder_pin_h/2 - (pp_screw_h + pp_overlap_h)/2 - pp_back_borders - pp_tollerance])
        cube([pp_back_holder_pin_w + pp_tollerance*2, pp_external_belt_d*2,
pp_back_holder_pin_h + pp_tollerance*2], center=true);
        translate([-pp_holder_border_d/2 +  pp_back_holder_pin_w/2 - pp_tollerance, 0, - pp_back_holder_pin_h/2 - (pp_screw_h + pp_overlap_h)/2 - pp_back_borders - pp_tollerance])
        cube([pp_back_holder_pin_w + pp_tollerance*2, pp_external_belt_d * 2, pp_back_holder_pin_h + pp_tollerance*2], center=true);
    }
};

// Piston
if (pp_show_piston)
union()
{
    // Piston Boby
    difference(){
        overlap= 1;
        cyl_h= pp_screw_h + overlap*2;
        screw_h= pp_overlap_h + overlap*2;
        
        rails(d1 = pp_d2_1 + pp_holding_step, d2= pp_d2_1, ratio=0.5, h= pp_screw_h + pp_overlap_h, num= pp_rail_num);
        translate([0, 0, -(screw_h + cyl_h)/2 + overlap])
        union() {
            ext_d= pp_d2_2 + pp_holding_step;
            translate([0, 0, cyl_h/2 + pp_overlap_h + overlap])
            cylinder(d= ext_d, h= cyl_h, center=true);
            translate([0, 0, + screw_h/2])
            rotate([0, 0, 360/pp_pitch*overlap])
            push_pull_screw(d1=ext_d, d2= pp_d2_2, ratio=0.5, num= pp_screw_num, pitch=pp_pitch, h= screw_h);
      }    
    };
    // Piston_head
    //
    // Bottom border transition
    translate([0, 0, (pp_screw_h + pp_overlap_h)/2])
    cylinder(d1= pp_d2_1 + pp_holding_step, d2=pp_d1_1, h=pp_piston_borders/2, center=false);
    // Bottom border
    translate([0, 0, (pp_screw_h + pp_overlap_h)/2 + pp_piston_borders/2])
    cylinder(d=pp_d1_1, h=pp_piston_borders, center=false);
    // head body
    translate([0, 0, (pp_screw_h + pp_overlap_h)/2 + pp_piston_borders*1.5])
    cylinder(d=pp_oring_inner_d, h=pp_oring_num*pp_oring_d, center=false);
    // Bottom border-boby transition
    translate([0, 0, (pp_screw_h + pp_overlap_h)/2 + pp_piston_borders*1.5])
    cylinder(d1=pp_oring_inner_d + pp_oring_d*3/8, d2=pp_oring_inner_d, h=pp_oring_d/4, center=false);
    translate([0, 0, (pp_screw_h + pp_overlap_h)/2 + pp_piston_borders*1.5])
    cylinder(d1=pp_oring_inner_d + pp_oring_d/4, d2=pp_oring_inner_d, h= pp_oring_d*3/8, center=false);
    //Top border-boby transition
    translate([0, 0, (pp_screw_h + pp_overlap_h)/2 + pp_piston_borders*1.5 + pp_oring_num*pp_oring_d - pp_oring_d/4])
    cylinder(d2=pp_oring_inner_d + pp_oring_d*3/8, d1=pp_oring_inner_d, h=pp_oring_d/4, center=false);
    translate([0, 0, (pp_screw_h + pp_overlap_h)/2 + pp_piston_borders*1.5 + pp_oring_num*pp_oring_d - pp_oring_d*3/8])
    cylinder(d2=pp_oring_inner_d + pp_oring_d/4, d1=pp_oring_inner_d, h= pp_oring_d*3/8, center=false);
    // Top border
    translate([0, 0, (pp_screw_h + pp_overlap_h)/2 + pp_piston_borders*1.5 + pp_oring_num*pp_oring_d])
    cylinder(d=pp_d1_1, h=pp_piston_borders, center=false);
    // Top transition
    translate([0, 0, (pp_screw_h + pp_overlap_h)/2 + pp_piston_borders*2.5 + pp_oring_num*pp_oring_d])
    cylinder(d1=pp_d1_1, d2= pp_d1_1/2, h=pp_piston_borders/2, center=false);
};


// Screw
//
if (pp_show_screw)
translate ([pp_show_assemble ? 0 : - pp_gap, 0, 0])
union() {
    // Screw Screw
    push_pull_screw(d1= pp_d3 + pp_holding_step, d2= pp_d3, ratio=0.5, num= pp_screw_num, pitch=pp_pitch, h= pp_screw_h + pp_overlap_h);
    // Screw_holder
    translate([0, 0, - pp_back_borders - (pp_screw_h + pp_overlap_h)/2])
    cylinder(d= pp_holder_border_d, h=pp_back_borders, center=false);
    translate([0, 0, -pp_back_borders - (pp_back_holder_pin_h + pp_tollerance*2) - (pp_screw_h + pp_overlap_h)/2])
    cylinder(d= pp_holder_border_d - (pp_back_holder_pin_w*2 + pp_tollerance*2), h= pp_back_holder_pin_h + pp_tollerance*2, center=false);
    translate([0, 0, - (pp_belt_with_thread_bottom + pp_external_belt + pp_back_thread2) - pp_back_borders*2 - (pp_back_holder_pin_h + pp_tollerance*2) - (pp_screw_h + pp_overlap_h)/2])
    cylinder(d= pp_holder_border_d, h= pp_back_borders + pp_belt_with_thread_bottom + pp_external_belt + pp_back_thread2, center=false);
    // Screw handler
    translate([0, 0, -pp_screw_handle_h/2 - (pp_belt_with_thread_bottom + pp_external_belt + pp_back_thread2) - pp_back_borders*2 - (pp_back_holder_pin_h + pp_tollerance*2) - (pp_screw_h + pp_overlap_h)/2])
    rough_handle(d= pp_screw_handle_d, h=pp_screw_handle_h, rough= pp_screw_handle_rough);
};

// Helps to print highest thing in the set
//
if (pp_show_print_helper)
translate ([pp_show_assemble ? - pp_gap : - pp_gap * 2, 0, 0])
rotate (45)
union()
{
    translate([0, 0, - pp_body_length/2 + (pp_screw_h + pp_overlap_h)/2])
    cube([pp_holder_border_d, pp_min_wall, pp_body_length], center= true);
    translate([0, 0, - pp_body_length/2 + (pp_screw_h + pp_overlap_h)/2])
    cube([pp_min_wall, pp_holder_border_d, pp_body_length], center= true);
}


// Pins for mechanism
if (pp_show_pins)
translate ([0, pp_show_assemble ? 0 : - pp_gap,  - pp_back_holder_pin_h/2 - (pp_screw_h + pp_overlap_h)/2 - pp_back_borders - pp_tollerance])
intersection()
{
    cylinder(d= pp_d1_1, h= pp_back_holder_pin_h + 2, center=true);
    union() {
        translate([pp_holder_border_d/2 -  pp_back_holder_pin_w/2 + pp_tollerance, 0, 0])
            cube([pp_back_holder_pin_w, pp_external_belt_d,
    pp_back_holder_pin_h], center=true);
            translate([-pp_holder_border_d/2 +  pp_back_holder_pin_w/2 - pp_tollerance, 0, 0])
            cube([pp_back_holder_pin_w, pp_external_belt_d,
    pp_back_holder_pin_h], center=true);
    }
};

// Body
if (pp_show_body)
translate ([0, pp_show_assemble ? 0 : pp_gap, 0])
difference()
{
    translate([0, 0, - (pp_screw_h + pp_overlap_h)/2 - pp_back_thread1*pp_internal_thread_h_ratio])
    union()
    {
        cylinder(d= pp_external_belt_d, h= pp_body_length, center=false);
        translate([0, 0, pp_body_length - pp_body_thread_h - pp_body_thread_interval])
        metric_thread_w_entry (diameter=pp_external_belt_d + pp_boby_thread_pitch*1.18, pitch=pp_boby_thread_pitch, thread_size= pp_body_thread_size, length= pp_body_thread_h, internal= false, n_starts= pp_body_thread_starts, cut_bottom=true, cut_top=true);
    }
    // Cut for piston mechanism
    union()
    {
        translate([0, 0, pp_screw_h*2 + pp_piston_head_h - (pp_screw_h + pp_overlap_h)/2])
        nibm_cut(center=false);
        translate([0, 0, - (pp_screw_h + pp_overlap_h)/2 - pp_back_thread1*pp_internal_thread_h_ratio -1])
        cylinder(d= pp_d, h= pp_screw_h*2 + pp_piston_head_h +  pp_back_thread1*pp_internal_thread_h_ratio + 1.01, center=false);
        translate([0, 0, - (pp_screw_h + pp_overlap_h)/2 - pp_back_thread1*(pp_internal_thread_h_ratio + 0.001)])
        metric_thread_w_entry (diameter=pp_d1_1+ pp_back_tread_pitch*1.18 + pp_tread_d_tollerance, pitch=pp_back_tread_pitch, length= pp_back_thread1*(pp_internal_thread_h_ratio + 0.001), internal=true, cut_bottom=true, cut_top=false);
    }
}

// Cup lower part
if (pp_show_cup2)
translate ([pp_show_assemble ? 0 : - pp_gap, pp_show_assemble ? 0 : pp_gap, - (pp_screw_h + pp_overlap_h)/2  - pp_back_thread1*pp_internal_thread_h_ratio] )
difference()
{
    // External
    union()
    {
        // Wide cylinder
        translate([0, 0, pp_body_length - pp_cup_wide_part_h + pp_min_wall])
        cylinder(d= pp_cup_d1, h= pp_cup_wide_part_h, center= false);
        // Narrow cylynder
        translate([0, 0, pp_body_length + pp_min_wall  - 0.01])
        cylinder(d= pp_cup_narrow_part_d, h= nibm_nib_h + 0.01, center= false);
        // Thread ower narrow cylinder to put top part on
        translate([0, 0, pp_body_length + pp_min_wall])
        metric_thread_w_entry (diameter=pp_cup_narrow_part_d + pp_cup_thread_pitch*1.18, pitch= pp_cup_thread_pitch, length= pp_cup_thread_h, internal=false, cut_bottom=true, cut_top=true);
    }
    // Cut
    union()
    {   
        // nib compartment
        translate([0, 0, pp_body_length  - 0.01])
        cylinder(d= nibm_nib_d, h= nibm_nib_h + 0.01, center= false);
        // thread to hold the pen
        translate([0, 0, pp_body_length - pp_body_thread_h - pp_body_thread_interval - 0.01])
            metric_thread_w_entry (diameter=pp_external_belt_d + pp_boby_thread_pitch*1.18 + pp_tread_d_tollerance, pitch=pp_boby_thread_pitch, thread_size= pp_body_thread_size, length= pp_body_thread_h + 0.01, internal= true, n_starts= pp_body_thread_starts, cut_bottom=true, cut_top=true);
        // place to get pen thread go through
        translate([0, 0, pp_body_length - pp_body_thread_h - pp_body_thread_interval - pp_cup_after_thread - 0.01])
        cylinder(d= pp_cup_d2, h= pp_cup_after_thread + 0.01, center= false);
        // place for pen body between nib and thread
        translate([0, 0, pp_body_length - pp_body_thread_interval - 0.01])
        cylinder(d= pp_external_belt_d + 2*pp_tollerance, h= pp_body_thread_interval + 0.01, center= false);
    };
}

// Cup upper part and clip
if (pp_show_cup1)
    translate ([pp_show_assemble ? 0 : - pp_gap, pp_show_assemble ? 0 : - pp_gap, - (pp_screw_h + pp_overlap_h)/2  - pp_back_thread1*pp_internal_thread_h_ratio] )
difference()
{
    base= pp_body_length + pp_min_wall;
    //Body
    union()
    {
        translate([0, 0, pp_body_length + pp_min_wall])
        cylinder(d= pp_cup_d1, h=nibm_nib_h, center= false);
        intersection()
        {
            union()
            {
                translate([0, 0, base - pp_cup_wide_part_h - 2*(pp_clip_gap + pp_clip_thickness)])
                cylinder(d= pp_cup_d1 + 2*(pp_clip_gap + pp_clip_thickness), h= nibm_nib_h + pp_cup_wide_part_h, celter= false);
                translate([0, 0, base - 2*(pp_clip_gap + pp_clip_thickness) + nibm_nib_h])
                cylinder(d1= pp_cup_d1 + 2*(pp_clip_gap + pp_clip_thickness), d2= pp_cup_d1, h= 2*(pp_clip_gap + pp_clip_thickness), celter= false);
            }
            translate([-pp_clip_width/2, 0, base - pp_cup_wide_part_h - 2*(pp_clip_gap + pp_clip_thickness)])
            cube([pp_clip_width, pp_cup_d1 + 2*(pp_clip_gap + pp_clip_thickness), pp_body_length +pp_cup_wide_part_h + 2*(pp_clip_gap + pp_clip_thickness)], celter= false);
        }
    }
    // Cut
    union()
    {
        // hole for lower pat to get in
        translate([0, 0, base  - 0.01])
            cylinder(d= pp_cup_narrow_part_d + pp_tollerance*2, h= nibm_nib_h + 0.02, center= false);
        // thread to connect lower part
        translate([0, 0, base -0.01])
            metric_thread_w_entry (diameter=pp_cup_narrow_part_d + pp_cup_thread_pitch*1.18 + pp_tread_d_tollerance, pitch= pp_cup_thread_pitch, length= pp_cup_thread_h * pp_internal_thread_h_ratio + 0.02, internal=true, cut_bottom=true, cut_top=true);
        // cut of clip
        translate([0, 0, base - (pp_cup_wide_part_h - pp_clip_gap) - 0.01])
        cylinder(d= pp_cup_d1+ 2* pp_clip_gap,
        h= pp_cup_wide_part_h - pp_clip_gap + 0.01, celter= false);
        translate([0, 0, base - pp_cup_wide_part_h])
        cylinder(d2= pp_cup_d1+ 2* pp_clip_gap, d1= pp_cup_d1, 
        h= pp_clip_gap, celter= false);
        translate([0, 0, base - pp_cup_wide_part_h - pp_clip_gap/2])
        cylinder(d= pp_cup_d1, 
        h= pp_clip_gap, celter= false);
        translate([0, 0, base - pp_cup_wide_part_h - 2*(pp_clip_gap + pp_clip_thickness) - 0.01])
        cylinder(d2= pp_cup_d1, d1= pp_cup_d1 + 2*(pp_clip_gap + pp_clip_thickness), 
        h= 2*(pp_clip_gap + pp_clip_thickness) + 0.01, celter= false);
    }
}
//rails(num=2);
//push_pull_screw();
/*
difference(){
    cylinder(5,d=10,center=true);
    cylinder(7,d=10-1.4,center=true);
};
translate([10.1,0,0])
difference(){
    cylinder(5,d=10,center=true);
    cylinder(7,d=10-1.6,center=true);
};
cube([10,0.7,5],center=true);
*/
