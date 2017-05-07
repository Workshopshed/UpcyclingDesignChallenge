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
            cube([5,88.3,10]);
    translate([-84,7,0])
        cube([3,65,7]);
    translate([8,70,0])
        rotate([0,0,90])
            cube([5,88,10]);
    //Front
    translate([34.5,18,0])
        cube([5,44,10]);
    translate([6.1,9.38,0])
        rotate([0,0,-67])
            cube([5,35,10]);
    translate([38.16,56.5,0])
        rotate([0,0,67])
            cube([5,35,10]);
    //Front Buffers
    translate([65,55.5,0])
        rotate([0,0,90])
            cube([6.5,25,6.5]);
    translate([65,18,0])
        rotate([0,0,90])
            cube([6.5,25,6.5]);
    //Back
    translate([-105.5,18,0])
        cube([5,40,10]);
    translate([-80,5,0])
        rotate([0,0,64])
            cube([5,31,10]);
    translate([-107.7,61.5,0])
        rotate([0,0,-64])
            cube([5,31,10]);
    //Back Buffers
    translate([-105,55.5,0])
        rotate([0,0,90])
            cube([6.5,25,6.5]);
    translate([-105,18,0])
        rotate([0,0,90])
            cube([6.5,25,6.5]);
	}
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