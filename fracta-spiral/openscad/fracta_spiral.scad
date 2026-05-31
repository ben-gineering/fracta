include <BOSL2/std.scad>;

$fn = 96;

show_bulb_preview = false;

fin_count = 18;
fin_height = 72;
fin_width = 54;
fin_thickness = 3;
spiral_radius = 78;
spiral_height = 190;
spiral_turns = 1.2;
rotation_bias = 28;
vertical_scale = 1.0;
base_scale = 0.78;
top_scale = 0.34;
fin_tilt = 18;

hardware_hole_diameter = 42;
top_mount_diameter = 56;
bulb_diameter = 95;
bulb_height = 130;
bulb_z = 24;

function lerp(a,b,t) = a + (b-a)*t;
function ease_in_out(t) = 3*t*t - 2*t*t*t;

module teardrop_fin_2d(w=50,h=70) {
    hull() {
        translate([0,h*0.28]) circle(d=w*0.62);
        translate([0,-h*0.34]) circle(d=w*0.22);
    }
}

module fin_element(w=50,h=70,t=3) {
    linear_extrude(height=t)
        teardrop_fin_2d(w=w,h=h);
}

module top_mount_disc(outer_d=56, hole_d=42, thickness=4) {
    translate([0,0,spiral_height+10])
        linear_extrude(height=thickness)
            difference() {
                circle(d=outer_d);
                circle(d=hole_d);
            }
}

module bulb_preview() {
    color("gold",0.25)
        translate([0,0,bulb_z])
            cylinder(d=bulb_diameter, h=bulb_height);
}

module spiral_fin(i=0) {
    t = i/(fin_count-1);
    eased = ease_in_out(t);
    angle = 360*spiral_turns*t;
    z = spiral_height * t;
    scale_f = lerp(base_scale, top_scale, eased);

    rotate([0,0,angle])
        translate([spiral_radius,0,z])
            rotate([0,fin_tilt,angle + rotation_bias])
                scale([scale_f, scale_f*vertical_scale, 1])
                    fin_element(w=fin_width,h=fin_height,t=fin_thickness);
}

module fracta_spiral() {
    for (i = [0:fin_count-1])
        spiral_fin(i);

    top_mount_disc(outer_d=top_mount_diameter, hole_d=hardware_hole_diameter, thickness=4);

    if (show_bulb_preview)
        bulb_preview();
}

fracta_spiral();
