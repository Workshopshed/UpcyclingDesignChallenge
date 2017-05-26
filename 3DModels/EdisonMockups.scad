module EdisonArduino()
{
	color("SteelBlue")
    //Mock Edison Arduino Breakout
    difference() {
    cube([122.3,72,3]);
	EdisonArduinoMountingHoles(1.5);
}

module EdisonArduinoMountingHoles(radius)
{
    //Mounting Holes
    translate([6.3,6.3,-3])
        cylinder(h=10,r=radius,$fn=30);
    translate([6.3,59.1,-3])
        cylinder(h=10,r=radius,$fn=30);
    translate([48,27.2,-3])
        cylinder(h=10,r=radius,$fn=30);    
    translate([48,51.5,-3])
        cylinder(h=10,r=radius,$fn=30);    
    translate([106.6,11.9,-3])
        cylinder(h=10,r=radius,$fn=30);  
    translate([106.4,60.2,-3])
        cylinder(h=10,r=radius,$fn=30); 
    }
}


module EdisonMini() {
	color("SteelBlue")
	difference() {
    cube([60,29,3]);
	EdisonMiniMountingHoles(1.5);
	}
}

module EdisonMiniMountingHoles(radius) {
//Mounting Holes
    translate([3,3,-3])
        cylinder(h=10,r=radius,$fn=30);
    translate([45,3,-3])
        cylinder(h=10,r=radius,$fn=30);
    translate([45,25.5,-3])
        cylinder(h=10,r=radius,$fn=30);    
    translate([3,25.5,-3])
        cylinder(h=10,r=radius,$fn=30);    
}

//EdisonArduino();
//EdisonMini();