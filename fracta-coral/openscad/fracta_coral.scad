include <BOSL2/std.scad>;

$fn = 72;

cluster_count = 10;
cluster_levels = 4;
cluster_angle = 34;
cluster_height = 150;
cluster_radius = 68;
branch_diameter = 5.2;
hub_diameter = 28;
hub_height = 18;
stem_diameter = 8;
mount_ring_diameter = 58;
hardware_hole_diameter = 42;
cluster_z_span = 74;
show_inner_cage = true;
inner_cage_diameter = 112;

module coral_branch(level=0, len=42, d=5) {
    if (level < cluster_levels) {
        cylinder(d1=d, d2=max(1.7,d*0.82), h=len);
        translate([0,0,len])
            for (a = [0,120,240])
                rotate([cluster_angle + level*3,0,a + level*12])
                    coral_branch(level+1, len*0.68, max(1.7,d*0.76));
    }
}

module coral_cluster(a=0, tilt=0, z=0) {
    rotate([0,0,a])
        translate([cluster_radius,0,hub_height + z])
            rotate([tilt,20,0])
                coral_branch(0, cluster_height*0.2, branch_diameter);
}

module top_mount() {
    translate([0,0,cluster_height+44])
        linear_extrude(height=4)
            difference() {
                circle(d=mount_ring_diameter);
                circle(d=hardware_hole_diameter);
            }
}

module inner_cage(z=34, d=112, width=4.5, h=52) {
    difference() {
        translate([0,0,z])
            cylinder(d=d, h=h);
        translate([0,0,z-1])
            cylinder(d=d-2*width, h=h+2);
    }
}

module fracta_coral() {
    cylinder(d=stem_diameter, h=cluster_height+44);
    cylinder(d=hub_diameter, h=hub_height);

    for (i = [0:cluster_count-1])
        coral_cluster(
            a=i*360/cluster_count,
            tilt=-42 + (i%4)*11,
            z=(i%2)*(cluster_z_span*0.5)
        );

    if (show_inner_cage)
        inner_cage(z=26, d=inner_cage_diameter, width=4.5, h=58);

    top_mount();
}

fracta_coral();
