include <BOSL2/std.scad>;

$fn = 72;

hub_height = 22;
hub_diameter = 30;
canopy_radius = 120;
canopy_height = 164;
branch_count = 8;
branch_levels = 4;
branch_angle = 24;
branch_twist = 14;
branch_thickness = 5.8;
mount_ring_diameter = 58;
hardware_hole_diameter = 42;
trunk_diameter = 10;
inner_bulb_clearance = 78;
show_lower_perimeter = true;
lower_perimeter_diameter = 184;
show_mid_ring = true;
mid_ring_diameter = 126;
ring_width = 6;
ring_thickness = 3.2;

module branch_bar(len=50, d=6) {
    rotate([0,90,0])
        cylinder(d=d, h=len);
}

module canopy_branch(level=0, len=56, d=6) {
    if (level < branch_levels) {
        branch_bar(len=len, d=d);
        for (s = [-1,1])
            translate([len,0,0])
                rotate([0,s*branch_angle,branch_twist*s])
                    canopy_branch(level+1, len*0.74, max(2.2,d*0.78));
    }
}

module canopy_arm(a=0) {
    rotate([0,0,a])
        translate([0,0,hub_height])
            rotate([0,-62,0])
                canopy_branch(0, canopy_radius*0.3, branch_thickness);
}

module arm_root(a=0, len=36, d=10) {
    rotate([0,0,a])
        translate([0,0,hub_height-2])
            rotate([0,-62,0])
                rotate([0,90,0])
                    cylinder(d=d, h=len);
}

module top_mount() {
    translate([0,0,canopy_height+12])
        linear_extrude(height=4)
            difference() {
                circle(d=mount_ring_diameter);
                circle(d=hardware_hole_diameter);
            }
}

module top_stem() {
    cylinder(d=trunk_diameter, h=canopy_height);
}

module support_ring(z=18, d=184, width=4.8, thickness=3) {
    translate([0,0,z])
        linear_extrude(height=thickness)
            difference() {
                circle(d=d);
                circle(d=d-2*width);
            }
}

module fracta_canopy() {
    union() {
        top_stem();
        cylinder(d=hub_diameter, h=hub_height);

        for (a = [0:360/branch_count:360-360/branch_count]) {
            arm_root(a=a, len=30, d=9.5);
            canopy_arm(a);
        }

        if (show_mid_ring)
            support_ring(z=64, d=mid_ring_diameter, width=ring_width, thickness=ring_thickness);

        if (show_lower_perimeter)
            support_ring(z=18, d=lower_perimeter_diameter, width=4.8, thickness=3);

        top_mount();
    }
}

fracta_canopy();
