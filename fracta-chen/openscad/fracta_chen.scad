include <BOSL2/std.scad>;

$fn = 36;

// Fracta Chen
// First-pass Chen attractor study generated from sampled trajectories.
// Uses a small built-in Euler integrator to generate points directly in OpenSCAD.

// Chen system parameters
chen_a = 35;
chen_b = 3;
chen_c = 28;
dt = 0.0008;
settle_steps = 2400;
sample_steps = 900;
sample_stride = 3;
trajectory_count = 3;
trajectory_offsets = [
    [0,0,0],
    [0.22,-0.18,0.12],
    [-0.18,0.16,-0.10]
];

// Display shaping
path_diameter = 4.2;
waist_scale = [4.8, 4.8, 3.1];
model_rotation = [90,0,18];
model_shift = [0,0,112];

function vadd(a,b) = [a[0]+b[0], a[1]+b[1], a[2]+b[2]];
function vmul(a,s) = [a[0]*s, a[1]*s, a[2]*s];
function chen_deriv(p) = [
    chen_a*(p[1]-p[0]),
    (chen_c-chen_a)*p[0] - p[0]*p[2] + chen_c*p[1],
    p[0]*p[1] - chen_b*p[2]
];
function euler_step(p, h) = vadd(p, vmul(chen_deriv(p), h));
function evolve(p, steps, h) =
    steps <= 0 ? p : evolve(euler_step(p,h), steps-1, h);
function trajectory_points(p, steps, stride, h, i=0) =
    i >= steps ? [] :
    let(np = euler_step(p,h))
    concat(
        (i % stride == 0 ? [np] : []),
        trajectory_points(np, steps, stride, h, i+1)
    );
function scaled_point(p) = [p[0]*waist_scale[0], p[1]*waist_scale[1], p[2]*waist_scale[2]];

module point_link(p1, p2, d=4) {
    hull() {
        translate(p1) sphere(d=d);
        translate(p2) sphere(d=d);
    }
}

module trajectory_tube(points, d=4) {
    for (i = [0:len(points)-2])
        point_link(scaled_point(points[i]), scaled_point(points[i+1]), d=d);
}

module chen_bundle() {
    rotate(model_rotation)
        translate(model_shift)
            union() {
                for (k = [0:trajectory_count-1]) {
                    seed0 = [0.12, 0.18, 0.15];
                    seed = [
                        seed0[0] + trajectory_offsets[k][0],
                        seed0[1] + trajectory_offsets[k][1],
                        seed0[2] + trajectory_offsets[k][2]
                    ];
                    settled = evolve(seed, settle_steps, dt);
                    pts = trajectory_points(settled, sample_steps, sample_stride, dt);
                    trajectory_tube(pts, d=path_diameter);
                }
            }
}

module fracta_chen() {
    chen_bundle();
}

fracta_chen();
