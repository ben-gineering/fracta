include <BOSL2/std.scad>;

$fn = 72;

levels = 4;
branch_scale = 0.7;
branch_angle = 34;
leaf_length = 88;
leaf_width = 10;
leaf_thickness = 3;
stem_height = 182;
ring_diameter = 58;
hardware_hole_diameter = 42;
arm_count = 6;
arm_drop = 26;
arm_radius = 20;
show_center_hub = true;
hub_diameter = 26;
show_lower_ring = true;
lower_ring_diameter = 118;

module leaf_segment(len=80, width=10, thickness=3) {
    linear_extrude(height=thickness)
        hull() {
            translate([0,0]) circle(d=width);
            translate([len,0]) circle(d=width*0.38);
        }
}

module branch(level=0, len=80, width=10) {
    if (level < levels) {
        leaf_segment(len=len, width=width, thickness=leaf_thickness);
        for (s = [-1,1])
            translate([len*0.44,0,leaf_thickness*0.5])
                rotate([0,0,s*branch_angle])
                    scale([branch_scale,branch_scale,1])
                        branch(level+1, len*0.82, width*0.92);
    }
}

module fern_arm(a=0, z=0) {
    rotate([0,0,a])
        translate([0,arm_radius,z])
            rotate([90-arm_drop,0,0])
                branch(0, leaf_length, leaf_width);
}

module top_mount() {
    translate([0,0,stem_height+8])
        linear_extrude(height=4)
            difference() {
                circle(d=ring_diameter);
                circle(d=hardware_hole_diameter);
            }
}

module lower_ring(z=18, outer_d=118, width=5, thickness=2.4) {
    translate([0,0,z])
        linear_extrude(height=thickness)
            difference() {
                circle(d=outer_d);
                circle(d=outer_d - 2*width);
            }
}

module center_hub(z=20, d=26, h=18) {
    translate([0,0,z])
        cylinder(d=d, h=h);
}

module fracta_fern() {
    cylinder(d=8, h=stem_height);

    if (show_center_hub)
        center_hub(z=18, d=hub_diameter, h=18);

    for (a = [0:360/arm_count:360-360/arm_count])
        fern_arm(a=a, z=24);

    if (show_lower_ring)
        lower_ring(z=22, outer_d=lower_ring_diameter, width=5, thickness=2.4);

    top_mount();
}

fracta_fern();
