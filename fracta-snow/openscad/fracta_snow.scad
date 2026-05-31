include <BOSL2/std.scad>;

// Fracta Snow
// First-draft scaffold for a pendant lamp inspired by Koch snowflake geometry.
//
// This version focuses on:
// - a deterministic 2D recursive snowflake outline
// - stacked layers to form a shade volume
// - a simple central hardware opening for an E27-style pendant socket
//
// Notes:
// - Dimensions are provisional and should be validated against actual IKEA hardware.
// - The code favors clarity over optimization for this first draft.

$fn = 96;

// ----------------------------
// Top-level parameters
// ----------------------------
preview_mode = false;
show_hardware_cutout = false;
show_support_ribs = true;

snow_depth = 2;                 // 0..3 recommended for early prototypes
shade_diameter = 220;
shade_height = 180;
layer_count = 15;
layer_thickness = 2.4;
vertical_spacing = 9;
layer_twist = 8;
scale_profile = [0.28, 0.36, 0.46, 0.58, 0.72, 0.84, 0.93, 1.00, 0.96, 0.88, 0.76, 0.62, 0.48, 0.36, 0.26];

hardware_hole_diameter = 42;    // provisional central opening
hardware_cap_diameter = 58;     // top cap support region
bulb_clearance_diameter = 95;   // clearance envelope for bulb
rib_count = 6;
rib_width = 8;
rib_thickness = 3;
rib_inset = 18;

// ----------------------------
// Geometry helpers
// ----------------------------
function vadd(a,b) = [a[0]+b[0], a[1]+b[1]];
function vsub(a,b) = [a[0]-b[0], a[1]-b[1]];
function vmul(a,s) = [a[0]*s, a[1]*s];
function vlen(a) = sqrt(a[0]*a[0] + a[1]*a[1]);
function vunit(a) = let(l=vlen(a)) (l == 0 ? [0,0] : [a[0]/l, a[1]/l]);
function vrot(a,deg) = [
    a[0]*cos(deg) - a[1]*sin(deg),
    a[0]*sin(deg) + a[1]*cos(deg)
];
function lerp(a,b,t) = a + (b-a)*t;
function p_lerp(a,b,t) = [lerp(a[0],b[0],t), lerp(a[1],b[1],t)];

function regular_polygon_points(n=3, r=10, phase=90) = [
    for (i = [0:n-1]) [r*cos(phase + 360*i/n), r*sin(phase + 360*i/n)]
];

function koch_segment(a, b, depth) =
    depth <= 0
        ? [a]
        : let(
            p1 = p_lerp(a,b,1/3),
            p3 = p_lerp(a,b,2/3),
            dir = vsub(p3,p1),
            peak = vadd(p1, vrot(dir, 60))
          )
          concat(
            koch_segment(a,  p1, depth-1),
            koch_segment(p1, peak, depth-1),
            koch_segment(peak, p3, depth-1),
            koch_segment(p3, b, depth-1)
          );

function closed_koch_polygon(points, depth) = concat(
    [for (i = [0:len(points)-1])
        each koch_segment(points[i], points[(i+1)%len(points)], depth)
    ]
);

module snowflake_2d(radius=100, depth=2) {
    pts = closed_koch_polygon(regular_polygon_points(n=3, r=radius, phase=90), depth);
    polygon(points=pts);
}

module snowflake_layer(radius=100, depth=2, thickness=2, center_hole=0) {
    linear_extrude(height=thickness)
        difference() {
            snowflake_2d(radius=radius, depth=depth);
            if (center_hole > 0)
                circle(d=center_hole);
        }
}

module top_mount_disc(outer_d=80, hole_d=42, thickness=4) {
    linear_extrude(height=thickness)
        difference() {
            circle(d=outer_d);
            circle(d=hole_d);
        }
}

module vertical_ribs(height=120, radius=70, count=6, width=8, thickness=3) {
    for (a = [0 : 360/count : 360 - 360/count])
        rotate([0,0,a])
            translate([radius,0,height/2])
                cube([thickness, width, height], center=true);
}

// ----------------------------
// Main lamp modules
// ----------------------------
module fracta_snow_shade() {
    total_height = (layer_count-1)*vertical_spacing;

    if (show_support_ribs)
        vertical_ribs(
            height=total_height + layer_thickness,
            radius=(shade_diameter/2) - rib_inset,
            count=rib_count,
            width=rib_width,
            thickness=rib_thickness
        );

    for (i = [0:layer_count-1]) {
        layer_scale = i < len(scale_profile)
            ? scale_profile[i]
            : 1;
        zpos = i * vertical_spacing;
        twist = (i - (layer_count-1)/2) * layer_twist;
        translate([0,0,zpos])
            rotate([0,0,twist])
                snowflake_layer(
                    radius=(shade_diameter/2) * layer_scale,
                    depth=snow_depth,
                    thickness=layer_thickness,
                    center_hole=hardware_hole_diameter
                );
    }

    // Top support disc for socket/collar area
    translate([0,0,total_height + layer_thickness])
        top_mount_disc(
            outer_d=hardware_cap_diameter,
            hole_d=hardware_hole_diameter,
            thickness=4
        );
}

module bulb_clearance_preview(height=130, diameter=95) {
    color("gold", 0.25)
        translate([0,0,20])
            cylinder(h=height, d=diameter);
}

module fracta_snow_assembly() {
    fracta_snow_shade();

    if (show_hardware_cutout)
        bulb_clearance_preview(height=130, diameter=bulb_clearance_diameter);
}

// ----------------------------
// Render
// ----------------------------
fracta_snow_assembly();
