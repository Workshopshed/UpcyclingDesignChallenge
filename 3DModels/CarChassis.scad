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
    cube([10,80,10]);
    translate([10,0,0])
        rotate([0,0,90])
            cube([10,80,10]);
    translate([-80,0,0])
        cube([10,80,10]);
    translate([10,70,0])
        rotate([0,0,90])
            cube([10,80,10]);
    //Front
    translate([30,15,0])
        cube([15,50,10]);
    translate([6.56,9.38,0])
        rotate([0,0,-70])
            cube([10,40,10]);
    translate([44.16,56.92,0])
        rotate([0,0,70])
            cube([10,40,10]);
    //Front Buffers
    translate([60,51.92,0])
        rotate([0,0,90])
            cube([15,30,10]);
    translate([60,12.92,0])
        rotate([0,0,90])
            cube([15,30,10]);
    //Back
    translate([-110,10,0])
        cube([15,60,10]);
    translate([-80,-0.0,0])
        rotate([0,0,82])
            cube([10,32,10]);
    translate([-111.67,75.55,0])
        rotate([0,0,-82])
            cube([10,32,10]);
    //Back Buffers
    translate([-110,51.92,0])
        rotate([0,0,90])
            cube([15,10,10]);
    translate([-110,12.92,0])
        rotate([0,0,90])
            cube([15,10,10]);
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
			cylinder(h=3,d=8,$fn=30);
			translate([0,0,3])
			cylinder(h=3,d1=8,d2=3,$fn=30);
			translate([0,0,10])
				cylinder(h=4,d=8,$fn=30);
		}
	}

}

module buffers() {
	w1 = 40;
	w2 = 40;
	translate([90,w1/2,5])
		bufferlarge();
	translate([90,-w1/2,5])
		bufferlarge();
	translate([-86,w2/2,3])
		buffersmall();
	translate([-86,-w2/2,3])
		buffersmall();
}

module bufferholes() {
	w1 = 40;
	w2 = 40;
	translate([90,w1/2,5])
		rotate([0,90,0]) {
			translate([0.25,0,-25])
					cylinder(h=50,d=2.5,$fn=30);
		}
	translate([90,-w1/2,5])
		rotate([0,90,0]) {
			translate([0.25,0,-25])
					cylinder(h=50,d=2.5,$fn=30);
		}
	translate([-86,w2/2,3])
		rotate([0,90,0]) {
			translate([0.25,0,-5])
					cylinder(h=40,d=2.5,$fn=30);
		}
	translate([-86,-w2/2,3])
		rotate([0,90,0]) {
			translate([0.25,0,-5])
					cylinder(h=40,d=2.5,$fn=30);
		}
}

module buffersmall() {
		rotate([0,90,0]) {
			cylinder(h=15,d=6,$fn=30);	
			}
}

module bufferlarge() {
		rotate([0,90,0]) {
			cylinder(h=16,d=9.5,$fn=30);
			}
}

/*
rotate([0,0,90])
    Edison();
*/

difference(){
	union() {
	Chassis();
	buffers();
	}
	mountingholes();
	bufferholes();
}