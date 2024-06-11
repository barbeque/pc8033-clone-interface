/* [Rendering options] */
// Show placeholder PCB in OpenSCAD preview
show_pcb = false;
// Lid mounting method
lid_model = "cap"; // [cap, inner-fit]
// Conditional rendering
render = "case"; // [all, case, lid]


/* [Dimensions] */
// Height of the PCB mounting stand-offs between the bottom of the case and the PCB
standoff_height = 5;
// PCB thickness
pcb_thickness = 1.6;
// Bottom layer thickness
floor_height = 1.2;
// Case wall thickness
wall_thickness = 2;
// Space between the top of the PCB and the top of the case
headroom = 0;

/* [M3 screws] */
// Outer diameter for the insert
insert_M3_diameter = 3.77;
// Depth of the insert
insert_M3_depth = 4.5;

/* [Hidden] */
$fa=$preview ? 10 : 4;
$fs=0.2;
inner_height = floor_height + standoff_height + pcb_thickness + headroom;

module wall (thickness, height) {
    linear_extrude(height, convexity=10) {
        difference() {
            offset(r=thickness)
                children();
            children();
        }
    }
}

module bottom(thickness, height) {
    linear_extrude(height, convexity=3) {
        offset(r=thickness)
            children();
    }
}

module lid(thickness, height, edge) {
    linear_extrude(height * 5, convexity=10) {
        offset(r=thickness)
            children();
    }
    translate([0,0,-edge])
    difference() {
        linear_extrude(edge, convexity=10) {
                offset(r=-0.2)
                children();
        }
        translate([0,0, -0.5])
         linear_extrude(edge+1, convexity=10) {
                offset(r=-1.2)
                children();
        }
    }
}


module box(wall_thick, bottom_layers, height) {
    if (render == "all" || render == "case") {
        translate([0,0, bottom_layers])
            wall(wall_thick, height) children();
        bottom(wall_thick, bottom_layers) children();
    }
    
    if (render == "all" || render == "lid") {
        translate([0, 0, height+bottom_layers+0.1])
        lid(wall_thick, bottom_layers, lid_model == "inner-fit" ? headroom-2.5: bottom_layers) 
            children();
    }
}

module mount(drill, space, height) {
    translate([0,0,height/2])
        difference() {
            cylinder(h=height, r=(space/2), center=true);
            cylinder(h=(height*2), r=(drill/2), center=true);
            
            translate([0, 0, height/2+0.01])
                children();
        }
        
}

module pcb() {
    thickness = 1.6;

    color("#009900")
    difference() {
        linear_extrude(thickness) {
            polygon(points = [[104.775,71.12], [200.025,71.12], [200.025,138.43], [104.775,138.43]]);
        }
    translate([107.95, 135.255, -1])
        cylinder(thickness+2, 1.5999999999999943, 1.5999999999999943);
    translate([196.85, 74.295, -1])
        cylinder(thickness+2, 1.5999999999999943, 1.5999999999999943);
    translate([196.85, 135.255, -1])
        cylinder(thickness+2, 1.5999999999999943, 1.5999999999999943);
    translate([107.95, 74.295, -1])
        cylinder(thickness+2, 1.5999999999999943, 1.5999999999999943);
    }
}

module case_outline() {
    polygon(points = [[107.95,141.986], [105.42275870971719,141.48330026563409], [103.280267,140.051733], [101.8486997343659,137.90924129028284], [101.346,135.382], [101.346,74.168], [101.84869973436591,71.64075870971719], [103.280267,69.498267], [105.42275870971719,68.06669973436591], [107.95,67.564], [196.85,67.564], [199.37724129028283,68.0666997343659], [201.519733,69.498267], [202.95130026563407,71.6407587097172], [203.454,74.168], [203.454,135.382], [202.9513002656341,137.90924129028284], [201.519733,140.051733], [199.37724129028283,141.4833002656341], [196.85,141.986], [107.95,141.986]]);
}

module Insert_M3() {
    translate([0, 0, -insert_M3_depth])
        cylinder(insert_M3_depth, insert_M3_diameter/2, insert_M3_diameter/2);
    translate([0, 0, -0.3])
        cylinder(0.3, insert_M3_diameter/2, insert_M3_diameter/2+0.3);
}

rotate([render == "lid" ? 180 : 0, 0, 0])
scale([1, -1, 1])
translate([-152.4, -104.77499999999999, 0]) {
    pcb_top = floor_height + standoff_height + pcb_thickness;

    difference() {
        box(wall_thickness, floor_height, inner_height) {
            case_outline();
        }

        translate([191.643, 105.28300000000002, inner_height+floor_height])
            cube([11.430000000000007, 52.07000000000001, floor_height + 12], center=true);
        translate([115.443, 105.41, inner_height+floor_height])
            cube([7.873999999999995, 65.024, floor_height + 12], center=true);
        
        /*translate([125,130,inner_height + floor_height + 8]) {
            rotate([180,0,0]) {
                
            linear_extrude(100) {
                text("PC-8033", size = 10);
            }
        }
        }*/
    }

    if (show_pcb && $preview) {
        translate([0, 0, floor_height + standoff_height])
            pcb();
    }

    if (render == "all" || render == "case") {
        // HOLE0 [('M3', 3)]
        translate([107.95, 135.255, floor_height])
        mount(3.2, 6.1, standoff_height)
            Insert_M3();
        // HOLE1 [('M3', 3)]
        translate([196.85, 74.295, floor_height])
        mount(3.2, 6.1, standoff_height)
            Insert_M3();
        // HOLE2 [('M3', 3)]
        translate([196.85, 135.255, floor_height])
        mount(3.2, 6.1, standoff_height)
            Insert_M3();
        // HOLE3 [('M3', 3)]
        translate([107.95, 74.295, floor_height])
        mount(3.2, 6.1, standoff_height)
            Insert_M3();
    }
}
