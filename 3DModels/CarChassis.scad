include <buffers.scad>;

module Furby() 
{
    //Overly simplified furby
    scale([0.9,0.85,1])
        cylinder(h=100,d=100,$fn=100);
}

module Edison()
{
    //Mock Edison
    difference() {
    cube([122.3,72,3]);
    //Mounting Holes
    translate([6.3,6.3,-3])
        cylinder(h=10,d=3,$fn=30);
    translate([6.3,59.1,-3])
        cylinder(h=10,d=3,$fn=30);
    translate([48,27.2,-3])
        cylinder(h=10,d=3,$fn=30);    
    translate([48,51.5,-3])
        cylinder(h=10,d=3,$fn=30);    
    translate([106.6,11.9,-3])
        cylinder(h=10,d=3,$fn=30);  
    translate([106.4,60.2,-3])
        cylinder(h=10,d=3,$fn=30); 
    }
}

module Chassis() {
	translate([40,-40,0]) {
    //Central core
    translate([12,8,0])
        cube([3,63,7]);
    translate([8,5,0])
        rotate([0,0,90])
            cube([5,81.5,10]);
    translate([-84,9,0])
        cube([3,62,7]);
    translate([8,70,0])
        rotate([0,0,90])
            cube([5,81.5,10]);
    //Front
    translate([37,40,5])
        cube([5,62,10],center=true);
    translate([23.2,9.65,5])
        rotate([0,0,-82])
            cube([5,33,10],center=true);
    translate([23.2,80-9.65,5])
        rotate([0,0,82])
            cube([5,33,10],center=true);

    //Back
    translate([-103,40,5])
        cube([5,62,10],center=true);

    translate([-88,9.65,5])
        rotate([0,0,82])
            cube([5,33,10],center=true);
    translate([-88,80-9.65,5])
        rotate([0,0,-82])
            cube([5,33,10],center=true);        
    }
    //Back Buffers
    buffers(-90,6.5,34);
	//Front Buffers
    buffers(78,6.5);
    mountingpoints();
  
}

module mountingpoints() {
	l = 140;
	w1 = 31;
	w2 = 32.5;
	for (a =[[77,w1/2,0],[77,-w1/2,0],[77-l,w2/2,0],[77-l,-w2/2,0]])
	{
		translate(a) {
			cylinder(h=10,d=11,$fn=30);
		}
	}

}

module mountingholes() {
	l = 140;
	w1 = 31;
	w2 = 32.5;
	for (a =[[77,w1/2,-2],[77,-w1/2,-2],[77-l,w2/2,-2],[77-l,-w2/2,-2]])
	{
		translate(a) {
			cylinder(h=15,d=3,$fn=30);
			translate([0,0,10])
				cylinder(h=4,d=7,$fn=30);
		}
	}

}

/*
rotate([0,0,90])
    Edison();
*/

difference(){
	union() {
	Chassis();
	}
	mountingholes();
}