
//
// Piston o-rings parameters
//
// diameter to fit all mechanisms and piston
// 9 is minimum for 0.4 nozzle 8 is absolut
// minimum and it is fragile
// Practically, it is o-rings outer diameter
pp_try_d= 9; // [8-60]
// number of o-rings
pp_oring_num=2; // [1-4]
// Thicknes of the O-ring (diameter of cirle
// which was turned to make torus of o-ring)
pp_oring_d=2; // [0.5-5]
// how tightly will o-rings fit (0.3 looks good)
pp_oring_compression=0.3; // [0.1-0.5]

//
// Parameters piston mechanism
//
// working length of the screw (piston travel)
pp_screw_h= 20; // [5-40]
// "nonworking" part os the screw
// (how long part of piston will be still
// overlap with screw when piston pushed to far
// end, it should be long enough to do not break
// when you try to return the piston)
pp_overlap_h= 4; // [3-7]
// screw pitch (length for 1 turn)
pp_pitch= 7; // [5-12]
// number of rails * 2
pp_rail_num=2; // [1-2]
// number of screw rails * 2
pp_screw_num=2; // [1-2]
// make 45 degree pins for better printing
pp_45_pin=false;

//
// Piston knob (handle) parameters
//
// The handle diameter
pp_screw_handle_d=7;
// The handle length
pp_screw_handle_h=7;
// The handle cuts depth
pp_screw_handle_rough=0.3;

//
// Pen back parameters
//
// Back threads pitch
pp_back_tread_pitch=1; // [0.75 -1.5]
// length of thread in the body
// (total length with all gaps for better
// print and work)
pp_back_thread1=5; // [5-10]
// length back caup which cover piston turning knob
pp_back_thread2=4; // [4-10]
// belt which allow screw/unscrew mechanism
// into the body
pp_external_belt=3; // [3-10]
// dangerous thing if thread on the back more loose that cup thread (back will stuck in the cup forever)
pp_back_thread_for_cup= false;
// bottom of the back cup thickness
pp_back_back_h= pp_min_wall;

//
// Pen body Parameters
//
// Cup thread parameters on the body
// starts
pp_body_thread_starts=4; // [1-4]
// length of the thread
pp_body_thread_h=3; // [3-7]
// pitch of the thread
pp_body_thread_pitch=0.75; // [0.75-1.5]
// distance of between each thread turn
// (should be more or equal of pitch)
pp_body_thread_size=1;
// Distance from the body end with nib to the
// cup thread start (should not prevent your
// comfort grip of the pen, so should be
// before or after place where you hold
// your fingers)
// (-1 - very end of nib module)
pp_body_thread_interval= 30; // [-1,0-50]
// Try (if above parameter allow) to put thread
// for posting pen cup on the other end of pen body
pp_body_try_second_body_thread= true;
// Try to make thread step down
pp_body_try_thread_step_down=false;
// Diameter of the section equal body diameter
// minus this delta
// (-1 min possible)
pp_body_section_delta= 0; // [-1, 0-10]
// Section barier width
pp_body_section_barier_w= 0; // [0-10]
// Transition from diameter to thread [0-4]
// 0 - autometic to make 45 degree cut
pp_body_thread_pre_cone=0.5;

//
// Cup Parameters
//
// how long will be cup after thread wich hold
// the pen body
pp_cup_after_thread= 5; // [0-50]
//
// Parameters of the thread which connect
// two cup parts:
// pitch
pp_cup_thread_pitch= 1; // [0.75-1.5]
// length
pp_cup_thread_h= 7;
//
// Parameters of the clip:
// gap between clip and cup body
pp_clip_gap=1; // [0.5 - 1.5]
// Next two parameters determin how springy clip is
pp_clip_width= 4;
pp_clip_thickness= 3;

//
// Common parameters
//
pp_thread_angle=30;
