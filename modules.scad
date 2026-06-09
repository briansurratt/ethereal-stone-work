use <constants.scad>
// house_silhouette: five-sided house shape extruded to depth d
// e = length of the three orthogonal sides (square base)
// r = roof rise (height of apex above the top of the square)
module house_silhouette(trim_parameters) {
    w = trim_width(trim_parameters);
    h = trim_height(trim_parameters);
    p = trim_peak(trim_parameters);
    polygon(points = [
        [-w / 2,   0      ],  // bottom-left
        [ w / 2,   0      ],  // bottom-right
        [ w / 2,   h      ],  // top-right
        [ 0,       h + p  ],  // apex
        [-w / 2,   h      ],  // top-left
    ]);
}

module house_silhouette_rotated(trim_parameters, radius = 0) {
    rotate_extrude(angle = 90)
        translate([radius, 0])
            house_silhouette(trim_parameters);
}


module transition_silhouette(trim_parameters) {
    w = trim_width(trim_parameters);
    h = trim_height(trim_parameters);
    p = trim_peak(trim_parameters);
    polygon(points = [
        [-w / 2,   0      ],  // bottom-left
        [ w / 2,   0      ],  // bottom-right
        [ w / 2,   h      ],  // top-right
        [ 0,       h + p   ],  // apex
        [-w / 2 + 0.5,   h + p],  // top-left
        [-w / 2,   h + p - 0.5],  // top-left
    ]);
}

module door_negative(parameters) {

    fh = opening_frame_height(parameters);
    ow = opening_width(parameters);

    translate([0, fh, 0])
    circle(r = opening_width(parameters)/2);

    translate([0, fh/2, 0])
    square([ow, fh], center=true);

}

module wall_segment(wall_parameters, opening_parameters, trim_parameters) {

    wt = wall_thickness(wall_parameters);    
    wh = wall_height(wall_parameters);
    ww = wall_width(wall_parameters);

    linear_extrude(wt)
    difference() {
        translate([0, wh/2, 0])
        square([ww, wh], center=true);    
        door_negative(opening_parameters);
    }


    door_frame(opening_parameters, trim_parameters);

}

module door_frame_half(opening_parameters, trim_parameters) {

    oh = opening_height(opening_parameters);
    oah = opening_arch_height(opening_parameters);
    ow = opening_width(opening_parameters);
    ofh = opening_frame_height(opening_parameters);

    translate([0, oh-oah, 0])
    house_silhouette_rotated(trim_parameters, ow/2);

    translate([ow/2, oh/3 * 2, 0])
    rotate([90, 90, 0])
    rotate([0, 0, 90])
    linear_extrude(ofh)
    house_silhouette(trim_parameters);

}

module door_frame(opening_parameters, trim_parameters) {
    door_frame_half(opening_parameters, trim_parameters);
    mirror([1, 0, 0]) door_frame_half(opening_parameters, trim_parameters);
}

module interior_arc(interior_arc_parameters) {
    d = interior_arc_diameter(interior_arc_parameters);
    f = interior_arc_frame(interior_arc_parameters);

    cube([f, d/2, 5], center=true);
 
}


module internior_arches (p, w) {

    width = interior_arch_frame_width(p);
    height = interior_arch_frame_height(p);
    thickness = interior_arch_frame_thickness(p);
    diameter = interior_arch_diameter(p);
    radius = diameter / 2;

    translate([wall_width(w)/2 - thickness/2, wall_height(w) - height, -radius])
    rotate([0, 90, 0])
    difference() {
        translate([-width/2, 0, -thickness/2])
        cube([width, height, thickness]);
        cylinder(r=radius, h=thickness + 2, center=true);
    }

    translate([-wall_width(w)/2 + thickness/2, wall_height(w) - height, -radius])
    rotate([0, 90, 0])
    difference() {
        translate([-width/2, 0, -thickness/2])
        cube([width, height, thickness]);
        cylinder(r=radius, h=thickness + 2, center=true);
    }


}
