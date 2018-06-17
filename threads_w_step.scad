include <threads_w_cut.scad>

module thread_with_step(diameter=8, pitch=1, length=3, internal=false, n_starts=1, thread_size=-1, groove=false, square=false, rectangle=0, angle=30, taper=0, leadin=0, leadfac=1.0, cut_top= false, cut_bottom= true, pre_step=0.5, cone_step=0.5, step_to=10, step_bottom=false)
{
    union()
    {
        thread_h= length - pre_step - cone_step;
        step_d= diameter + (internal ? 0 : -pitch);
        translate([0,0,(step_bottom ? 0 : thread_h + pre_step)])
        cylinder(d1= step_bottom?step_to:step_d, d2= step_bottom?step_d:step_to,  h= pre_step);
        translate([0,0,(step_bottom ? cone_step : thread_h) - 0.01])
        cylinder(d= step_d, h= pre_step + 0.02);
        translate([0,0,(step_bottom ? cone_step + pre_step : 0)])
        metric_thread_w_entry(diameter, pitch, (length - pre_step - cone_step), internal, n_starts, thread_size, groove, square, rectangle, angle, taper, leadin, leadfac, cut_top, cut_bottom);
    }
}

//thread_with_step(step_bottom=true,internal=false);
