include <constants.scad>
use <modules.scad>



wall_segment(wall_parameters, opening_parameters, trim_parameters);

translate([0, 0, -cell_edge + 2* (wall_thickness(wall_parameters) + trim_peak(trim_parameters))])
mirror([0, 0, 1])
wall_segment(wall_parameters, opening_parameters, trim_parameters);


internior_arches(interior_arch_parameters, wall_parameters);


// wall alighment reference
// translate([-cell_edge/2, 0, -cell_edge + wall_thickness(wall_parameters)+ trim_peak(trim_parameters)] )
// #cube([cell_edge, 5, cell_edge], center=false);




translate([-cell_edge/2+trim_width/2, wall_height, 0])
rotate([90,0,  0])
linear_extrude(wall_height)
transition_silhouette(trim_parameters);

mirror([1, 0, 0])
translate([-cell_edge/2+trim_width/2, wall_height, 0])
rotate([90,0,  0])
linear_extrude(wall_height)
transition_silhouette(trim_parameters);

translate([-cell_edge/2, wall_height - trim_width/2, wall_thickness/2-rampart_width/2-0.5])
mirror([0, 1, 0])
rotate([90,0,  0])
rotate([0,90,  0])
linear_extrude(cell_edge)
transition_silhouette(trim_parameters);


// resize([0,0, wall_thickness(wall_parameters)], auto=true)
import("stls/socket.stl", convexity=10);
import("stls/pin.stl", convexity=3);