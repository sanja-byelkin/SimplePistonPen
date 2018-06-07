include <slices.scad>

module ears (d1=3, d2=2, ratio=0.9, num= 1)
{
    union()
    {
        intersection(){
            union() {
                for (s=[0:num-1])
                    rotate((180/num)*s)
                    square([(d1+1)*2, d2 * ratio], center= true);
            }
            circle(d= d1);
        };
        circle(d= d2);
    };
};

module push_pull_screw(d1=3, d2=2, ratio=0.9, num=1, pitch=10, h=20)
{
    linear_extrude(height=h, center= true, convexity=10, twist=h/pitch*360, slices=h/pitch*slices(d1/2))
    ears(d1, d2, ratio, num);
};

module rails(d1=3, d2=2, ratio=0.9, num=1, h=20)
{
    linear_extrude(height=h, center= true, convexity=num+1)
    ears(d1, d2, ratio, num);
};
