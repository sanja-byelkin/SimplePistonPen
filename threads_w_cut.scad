include <threads.scad>

module metric_thread_w_entry (diameter=8, pitch=1, length=1, internal=false, n_starts=1, thread_size=-1, groove=false, square=false, rectangle=0, angle=30, taper=0, leadin=0, leadfac=1.0, cut_top= false, cut_bottom= true)
{
    local_thread_size = thread_size == -1 ? pitch : thread_size;
    if (internal)
    {
        union()
        {
            metric_thread(diameter, pitch, length, internal, n_starts, thread_size, groove, square, rectangle, angle, taper, leadin, leadfac);
            if (cut_bottom)
                cylinder(d2=diameter - local_thread_size, d1= diameter + local_thread_size/20, h= local_thread_size, center=false);
            if (cut_top)
                translate([0,0, length - local_thread_size])
                cylinder(d1=diameter - local_thread_size, d2=diameter + local_thread_size/20, h= local_thread_size, center=false);
        }
    }
    else
    {
        cyl_h= length - (cut_bottom ? local_thread_size : 0) -
        (cut_top ? local_thread_size : 0);
        intersection(){
            union()
            {
                if (cut_bottom)
                    cylinder(d1=diameter - local_thread_size, d2= diameter, h= local_thread_size, center=false);
                translate([0, 0, cut_bottom ? local_thread_size : 0])
                cylinder(d= diameter, h= cyl_h, center=false);
                if (cut_top)
                    translate([0, 0, length - local_thread_size])
                    cylinder(d2=diameter - local_thread_size, d1= diameter, h= local_thread_size, center=false);
            }
            metric_thread(diameter, pitch, length, internal, n_starts, thread_size, groove, square, rectangle, angle, taper, leadin, leadfac);
        }
    }
};