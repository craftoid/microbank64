
/////////////////////////////////////////////////////////////////////////
//                                                                     //
//    6 bit light bulb communication system of the alte Staatsbank     //
//                                                                     //
/////////////////////////////////////////////////////////////////////////

// (c) bitcraftlab 2016

// NOTE: all dimensions based on estimates
// TODO: take measueres
// TODO: improve switches


// board dimensions

width = 110;            // width of the board   
height = width / 2;     // height of the board
depth = 1;              // depth of a single layer of wood
spacing = .5;          // spacing between the layers (for visualization)
d = depth + spacing;    // distance between layers
rounding = 5;           // radius of rounded corners

// chandelier dimensions

bulbs = 6;              // number of light bulbs
dlamps = 15;            // distance between the lamps
dstilt = 15;            // length of the stilts holding the bar
dbar = 15;              // length of the bars holding the lamps

hfoot = 3.0;            // height of a chandelier foot
rfoot = 9.0;            // radius of a chandelier foot
rsocket = 1.5;          // radius of a light bulb socket
dknob = 2.25;           // radius of the chandelier knobs
    
// distance from the feet to the left 
border = (width - (bulbs - 1) * dlamps) / 2;

// wood colors
wood = [
    [0.7, 0.4, 0.0, 1.0],
    [0.75, 0.5, 0.0, 1.0]
];

// lamp colors
lamps = [
    [1.0, 1.0, 1.0],
    [1.0, 0.0, 0.0],
    [0.0, 1.0, 0.0],
    [0.0, 0.0, 1.0],
    [1.0, 1.0, 0.0],
    [0.7, 0.7, 0.7]
];

// light bulb transparency
alpha = 0.5;            

// draw the layers of wood
layers();

// position the chandelier so it has equal distance to the left and the top
translate([0, height/2  - border, 5 * d])
    chandelier();

// create 5 layers of wood
module layers() {
    
    // layer 1
    color(wood[0])
        rounded_layer();

    // layer 2
    translate([0, 0, 1 * d])
        color(wood[0])
            rounded_layer();
    
    // layer 3    
    translate([0, 0, 2 * d])
        color(wood[1])
            switch_layer();
    
    // layer 4 
    translate([0, 0, 3 * d])
        color(wood[1])
            switch_layer();
  
    // layer 5 
    translate([0, 0, 4 * d])
        color(wood[1])
            switch_layer();
         // show the cut out template
         //%cutout_layer();
            
    // cut out
    
}

module chandelier() {
        
    // left foot
    translate([ - dlamps *  (bulbs - 1 ) / 2, 0, 0]) {
        cylinder(hfoot, rfoot, rfoot);
        translate([0, 0, hfoot])
            cylinder(dstilt, rsocket, rsocket);
    }
    
    // right foot
    translate([ + dlamps *  (bulbs - 1 ) / 2, 0, 0]) {
        cylinder(hfoot, rfoot, rfoot);
        translate([0, 0, hfoot])
            cylinder(dstilt, rsocket, rsocket);
    }
    
    // light bulb bar
    translate([0, 0, dstilt + hfoot])
        rotate(90, [1, 0, 0]) 
        {
            // horizontal bar
            rotate(90, [0, 1, 0])
                cylinder(dlamps * (bulbs - 1), rsocket, rsocket, center=true);
            
            // vertical bars + bulbs
            translate([ - dlamps *  (bulbs - 1 ) / 2 , 0, 0])
                for (i=[0:bulbs-1]) {
                    
                    // vertical bar
                    translate([i * dlamps, 0, 0]) {
                        cylinder(dbar, rsocket, rsocket);
                        sphere(dknob);
                    }
                    
                    // light bulb
                    translate([i * dlamps,  0 , dbar]) {
                        lightbulb(rsocket, color=lamps[i]);
                        sphere(dknob);
                    }
                }
        }
}

// simplified lightbulb
module lightbulb(rsocket, hsocket=3, size=2.75, color="lightgray") {

    // the socket
    color("lightgray")
        cylinder(hsocket, rsocket, rsocket);

    // the bulb
    color([color[0], color[1], color[2], alpha])
        translate([0, 0, size + hsocket])
            sphere(rsocket * size);
}

// create a rectangle with rounded corners
module rounded_rect(width, height, rounding = 10) {
  offset(rounding) {
        square([width - 2 * rounding, height - 2 * rounding], center=true);
  };
}


// square layer
module layer() {
    linear_extrude(depth)
        square([width, height], center=true);
}

// layer with rounded corners
module rounded_layer() {
    linear_extrude(depth)
        rounded_rect(width, height, rounding);
}

// layer with switches added
module switch_layer() {
    difference() {
        rounded_layer(width, height, depth, rounding);
        cutout_layer(width, height, depth, rounding);
    }
}

// make space for the switches
module cutout_layer() {
    translate([ - dlamps *  (bulbs - 1 ) / 2 , 0, 0])
    for (i=[0:bulbs-1]) {
        translate([i* dlamps, 0, 0])
            cutout_switch();
    }
}


module cutout_switch() {
    
    h = 10;             // height of the cut out
    gap = 0.5;            // gap between stuff
    
    ds = h- 2 * gap;    // switch length
    ws = 1;             // switch width
    cs = ds * 0.2;      // cube width

    aspect = 1.25;      // aspect ratio of the cutout square
    
    translate([0, -height/2, 0])
        difference() {
            cube([h, 2 * aspect * h, h],  center=true);
            translate([0, cs + ws/2 + gap, 0])
                cube([ds, ws, h], center=true);
            translate([ds/2 - cs/2, cs/2, 0])
                cube([cs, cs, h], center=true);
            translate([-ds/2 + cs/2, cs/2, 0])
                cube([cs, cs, h], center=true);
            
        };
}




