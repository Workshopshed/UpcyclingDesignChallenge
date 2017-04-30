
module exhaust() {
	translate([0,0,-1])
		rotate_extrude(convexity = 10, angle=90, $fn=100)
			translate([15, 0, 0])
				circle(r = 4, $fn = 100);
	translate([-40,15,0])
		rotate([0,90,0])
			scale([0.7,1,1])
				cylinder(h=40,d=17,$fn = 100);
	translate([-50,11,-2])
		rotate([0,90,0])
			scale([0.7,1,1])
				cylinder(h=10,d=7,$fn = 100);
	translate([-50,19,-2])
		rotate([0,90,0])
			scale([0.7,1,1])
				cylinder(h=10,d=7,$fn = 100);
	translate([10, -20, -6])
		cube([10,20,10]);
}

module battery() {
	cube([50,35,8]);
	translate([3,16,2])
		cube([44,4,8]);
	translate([6,26,7])
		cableclamp();
	translate([32,26,7])
		cableclamp();
}

module cableclamp() {
	cube([10,6,3]);
	translate([3,3,0])
		cylinder(h=4,d=3,$fn=30);
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

module Supports() {
	translate([6.3,59.1,9])
        cylinder(h=12,d=8,$fn=30);
	translate([6.3,6.3,9])
        cylinder(h=12,d=8,$fn=30);
    translate([106.6,11.9,9])
        cylinder(h=12,d=8,$fn=30);  
    translate([106.4,60.2,9])
        cylinder(h=12,d=8,$fn=30); 	
}

module Pulley() {
    cylinder(h=10,d=25,$fn=60);
	translate([0,0,8])
        cylinder(h=2,d=30,$fn=60);
    cylinder(h=2,d=30,$fn=60);
	for (a =[0:20:360]) {	
		rotate(a)
			translate([0,11.5,1])
				cube([2,2,8]);
	}
}

module Belt() {
	rotate([0,0,-130])
		rotate_extrude(convexity = 10, angle=220, $fn=100)
			translate([15, 0, 0])
				square([3,8]);

	translate([-31, 13, 0])	
	rotate([0,0,70])
		rotate_extrude(convexity = 10, angle=175, $fn=100)
			translate([6.5, 0, 0])
				square([3,8]);	

	translate([0, 15, 0])	
		rotate([0,0,82])	
			cube([3,30,8]);
	
	translate([-11, -14, 0])	
		rotate([0,0,53])	
			cube([3,32,8]);	
}

module GasTank() {
	hull() {
	sphere(d=5,$fn=60);
	translate([43,0,0])
		sphere(d=5,$fn=60);
	translate([43,25,0])
		sphere(d=5,$fn=60);	
	translate([0,25,0])
		sphere(d=5,$fn=60);	
	translate([0,0,7])	
		sphere(d=5,$fn=60);
	translate([43,0,7])
		sphere(d=5,$fn=60);
	translate([43,25,7])
		sphere(d=5,$fn=60);	
	translate([0,25,7])
		sphere(d=5,$fn=60);	
	}
	translate([-8,5,-1])
		rotate([0,60,0])
			cylinder(h=12,d=5,$fn=60);
}

module Base() {
	cube([30,20,3]);
	translate([-4,-5,0])	
	rotate([0,0,-55])	
		cube([15,30,3]);
	translate([8,6,0])	
		cube([29,30,3]);
}

module Holes() {
	 //Mounting Holes
    translate([6.3,6.3,-3])
        cylinder(h=10,d=3,$fn=30);
    translate([6.3,59.1,-3])
        cylinder(h=10,d=3,$fn=30);     
    translate([106.6,11.9,-3])
        cylinder(h=10,d=3,$fn=30);  
    translate([106.4,60.2,-3])
        cylinder(h=10,d=3,$fn=30); 
}

//translate([0,0,21])
//	Edison();
difference() {
union() {
Supports();
//cube([122.3,72,6]);
translate([40,44,11])
	exhaust(); //Todo slice a flat on the bottom
translate([0,0,6])
	battery();
translate([106.6,11.9,6])
	Pulley();
translate([75,25,6])
	scale([0.45,0.45,1])
		Pulley();
translate([106.6,11.9,6])
	Belt();
translate([77,45,8])
	GasTank();
translate([45,20,6])
	Base();
}
translate([0,0,15])
	Holes();
translate([-13,-9,0])
	cube([140,90,7]);
}