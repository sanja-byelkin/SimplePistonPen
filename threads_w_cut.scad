include <threads.scad>

function thread_depth(pitch=1, angle=30, internal= false) =
    pitch / (2 * tan(angle)) * (internal ? 0.625 : 5.3/8)*2;


module metric_thread_w_entry (diameter=8, pitch=1, length=1, internal=false, n_starts=1, thread_size=-1, groove=false, square=false, rectangle=0, angle=30, taper=0, leadin=0, leadfac=1.0, cut_top= false, cut_bottom= true)
{
    thread_depth= thread_depth(pitch, angle, internal);
    if (internal)
    {
        union()
        {
            metric_thread(diameter, pitch, length, internal, n_starts, thread_size, groove, square, rectangle, angle, taper, leadin, leadfac);
            if (cut_bottom)
                cylinder(d2=diameter - thread_depth, d1= diameter + thread_depth/20, h= thread_depth, center=false);
            if (cut_top)
                translate([0,0, length - thread_depth])
                cylinder(d1=diameter - thread_depth, d2=diameter + thread_depth/20, h= thread_depth, center=false);
        }
    }
    else
    {
        cyl_h= length - (cut_bottom ? thread_depth : 0) -
        (cut_top ? thread_depth : 0);
        intersection(){
            union()
            {
                if (cut_bottom)
                    cylinder(d1=diameter - thread_depth, d2= diameter, h= thread_depth, center=false);
                translate([0, 0, cut_bottom ? thread_depth : 0])
                cylinder(d= diameter, h= cyl_h, center=false);
                if (cut_top)
                    translate([0, 0, length - thread_depth])
                    cylinder(d2=diameter - thread_depth, d1= diameter, h= thread_depth, center=false);
            }
            metric_thread(diameter, pitch, length, internal, n_starts, thread_size, groove, square, rectangle, angle, taper, leadin, leadfac);
        }
    }
};
