$fn = $preview ? 32 : 128;

inches_to_mm = 25.4;
cell_edge = 2.5 * inches_to_mm;

echo("Cell edge:", cell_edge);

wall_width = cell_edge;
wall_thickness = 5;
wall_height = 3 * inches_to_mm;

// wall struct: [width, thickness, height]
WALL_WIDTH     = 0;
WALL_THICKNESS = 1;
WALL_HEIGHT    = 2;

function make_wall(width, thickness, height) = [width, thickness, height];

function wall_width(w)     = w[WALL_WIDTH];
function wall_thickness(w) = w[WALL_THICKNESS];
function wall_height(w)    = w[WALL_HEIGHT];

wall_parameters = make_wall(wall_width, wall_thickness, wall_height);

trim_width = 4;
trim_height = wall_thickness;
trim_peak = 2;

// trim struct: [width, height]
TRIM_WIDTH  = 0;
TRIM_HEIGHT = 1;
TRIM_PEAK = 2;

function make_trim(width, height, peak) = [width, height, peak];

function trim_width(t)  = t[TRIM_WIDTH];
function trim_height(t) = t[TRIM_HEIGHT];
function trim_peak(t) = t[TRIM_PEAK];

trim_parameters = make_trim(trim_width, trim_height, trim_peak);

rampart_height = 7;
rampart_width = trim_width;



// based on stormcast being on 32mm
opening_width= 35;
opening_height = (wall_height - rampart_height);
opening_frame_height = opening_height * 2/3;
opening_arch_height = opening_height * 1/3;

// opening struct: [width, height, frame_height, arch_height]
// indices
OPENING_WIDTH        = 0;
OPENING_HEIGHT       = 1;
OPENING_FRAME_HEIGHT = 2;
OPENING_ARCH_HEIGHT  = 3;

function make_opening(width, height) = [
    width,
    height,
    height * 2/3,
    height * 1/3,
];

function opening_width(o)        = o[OPENING_WIDTH];
function opening_height(o)       = o[OPENING_HEIGHT];
function opening_frame_height(o) = o[OPENING_FRAME_HEIGHT];
function opening_arch_height(o)  = o[OPENING_ARCH_HEIGHT];

opening_parameters = make_opening(opening_width, opening_height);

pillar_width = cell_edge - opening_width;

walkway_width = opening_width + 2 * rampart_width;

interior_arch_diameter = 49.5;

// interior_arc struct: [diameter, frame]
INTERIOR_ARC_DIAMETER = 0;
INTERIOR_ARC_FRAME_WIDTH    = 1;
INTERIOR_ARC_FRAME_HEIGHT   = 2;
INTERIOR_ARC_FRAME_THICKNESS = 3;

function make_interior_arch(diameter, thickness) = [
    diameter,
    diameter + 2 * thickness,
    diameter /2 + thickness,
    thickness
];

function interior_arch_diameter(a) = a[INTERIOR_ARC_DIAMETER];
function interior_arch_frame_width(a)    = a[INTERIOR_ARC_FRAME_WIDTH];
function interior_arch_frame_height(a)   = a[INTERIOR_ARC_FRAME_HEIGHT];
function interior_arch_frame_thickness(a) = a[INTERIOR_ARC_FRAME_THICKNESS];

interior_arch_parameters = make_interior_arch(interior_arch_diameter, wall_thickness);

