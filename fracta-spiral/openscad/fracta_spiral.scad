include <BOSL2/std.scad>;

$fn = 96;

show_bulb_preview = false;

fin_count = 42;
fin_height = 92;
fin_width = 52;
fin_thickness = 3.2;
spiral_radius = 76;
spiral_height = 220;
spiral_turns = 1.7;
rotation_bias = 74;
vertical_scale = 1.0;
base_scale = 0.98;
top_scale = 0.3;
fin_tilt = 74;
inner_ring_diameter = 88;
show_spine = true;
spine_diameter = 10;
show_connector_arcs = true;
connector_arc_span = 120;
connector_arc_width = 6;
connector_arc_thickness = 3.2;
connector_arc_positions = [38, 90, 142, 194];
connector_arc_offset = 10;
show_lower_bowl = true;
lower_bowl_height = 34;
lower_bowl_radius = 50;
add_helical_rail = true;
rail_diameter = 6;

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

module inner_spine() {
    if (show_spine)
        cylinder(d=spine_diameter, h=spiral_height + 8);
}

module arc_wedge(r=60, ang=90) {
    pts = concat(
        [[0,0]],
        [for (a = [-ang/2 : 4 : ang/2]) [r*cos(a), r*sin(a)]],
        [[0,0]]
    );
    polygon(points=pts);
}

module connector_arc(z=40, outer_d=96, width=6, thickness=2.4, span=120, offset=0) {
    translate([0,0,z])
        linear_extrude(height=thickness)
            intersection() {
                difference() {
                    circle(d=outer_d);
                    circle(d=outer_d - 2*width);
                }
                rotate(offset)
                    arc_wedge(r=outer_d/2 + 2, ang=span);
            }
}

module lower_bowl(z=70, r=48, h=30, wall=2.6) {
    translate([0,0,z])
        difference() {
            cylinder(r1=r, r2=r*0.72, h=h);
            translate([0,0,wall])
                cylinder(r1=r-wall, r2=r*0.72-wall, h=h);
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
    radial = spiral_radius - 18*eased;

    rotate([0,0,angle])
        translate([radial,0,z])
            rotate([0,fin_tilt,angle + rotation_bias])
                scale([scale_f, scale_f*vertical_scale, 1])
                    fin_element(w=fin_width,h=fin_height,t=fin_thickness);
}

module helical_rail() {
    for (i = [0:fin_count-2]) {
        t1 = i/(fin_count-1);
        t2 = (i+1)/(fin_count-1);
        e1 = ease_in_out(t1);
        e2 = ease_in_out(t2);
        a1 = 360*spiral_turns*t1;
        a2 = 360*spiral_turns*t2;
        z1 = spiral_height*t1;
        z2 = spiral_height*t2;
        r1 = spiral_radius - 18*e1;
        r2 = spiral_radius - 18*e2;
        p1 = [r1*cos(a1), r1*sin(a1), z1 + fin_thickness*0.5];
        p2 = [r2*cos(a2), r2*sin(a2), z2 + fin_thickness*0.5];
        hull() {
            translate(p1) sphere(d=rail_diameter);
            translate(p2) sphere(d=rail_diameter);
        }
    }
}

module fracta_spiral() {
    union() {
        inner_spine();

        if (show_lower_bowl)
            lower_bowl(z=72, r=lower_bowl_radius, h=lower_bowl_height, wall=2.6);

        if (add_helical_rail)
            helical_rail();

        for (i = [0:fin_count-1])
            spiral_fin(i);

        if (show_connector_arcs)
            for (idx = [0:len(connector_arc_positions)-1])
                connector_arc(
                    z=connector_arc_positions[idx],
                    outer_d=inner_ring_diameter - idx*4,
                    width=connector_arc_width,
                    thickness=connector_arc_thickness,
                    span=connector_arc_span,
                    offset=connector_arc_offset + idx*58
                );

        top_mount_disc(outer_d=top_mount_diameter, hole_d=hardware_hole_diameter, thickness=4);
    }

    if (show_bulb_preview)
        bulb_preview();
}

fracta_spiral();
