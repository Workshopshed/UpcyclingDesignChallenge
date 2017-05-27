include <EdisonMockups.scad>

module FurbyBase() {

linear_extrude(height = 8, center = true)
	import("FurbyBaseOutline.dxf");
}

module FurbyWall() {
difference() {
linear_extrude(height = 30, center = true)
	import("FurbyBaseOutline.dxf");

translate([4,4,0])
	scale([0.9,0.9,1.2])
		linear_extrude(height = 30, center = true)
			import("FurbyBaseOutline.dxf");

translate([5,22,-5])
	cube([74,5,28]);
}

}

module EdisonMounts() {
	translate([-3,2,0])
	difference() {
	union() {
		translate([9,16,3])
			cube([6,4,28]);
		translate([51,16,3])
			cube([16,4,28]);
	}
	translate([9,22,3])
		rotate([90,0,0])
			EdisonMiniMountingHoles(1);
	}
	
}	

module ModuleMounts() {
	translate([10,53,2])
		cube([58,3,4]);
	translate([13,62,2])
		cube([49,3,4]);	
}

module FurbyPivot() {
	//translate([60,15,25])
	//cube([7,38,10]);	
	
	translate([64,20,30])
	difference() {
		hull() {
		translate([-3,-2,-27])
			cube([10,4,20]);
		rotate([0,90,90])
			cylinder(d=7,h=4,center=true,$fn=40);
		}
		rotate([0,90,90])
			cylinder(d=2,h=9,center=true,$fn=40);	
		}	
	translate([64,38+14,30])
	difference() {
		hull() {
		translate([-3,-2,-27])
			cube([10,4,20]);
		rotate([0,90,90])
			cylinder(d=7,h=4,center=true,$fn=40);
		}
		rotate([0,90,90])
			cylinder(d=2,h=9,center=true,$fn=40);	
	}
}

module Platform() {
difference() {	
	translate([39,36,-8])
	scale([1,1.05,1])
		cylinder(d=80,h=8,center=true,$fn=70);

    //Chassis cutouts
    translate([70,0+2-0.25,-17])
        rotate([0,0,90])
            cube([5+0.5,81.5,10]);
    translate([70,65+2-0.25,-17])
        rotate([0,0,90])
            cube([5+0.5,81.5+0.5,10]);
	}
}

module Battery() {
	color("Blue")
		cylinder(d=17,h=64,center=true,$fn=50);
}

module Powerboard() {
	color("DarkSlateGray")
		cube([23,12,3],center=true,$fn=50);
}

module Audioboard() {
	color("IndianRed")
		cube([25,15,3],center=true,$fn=50);
}

module Motorboard() {
	color("DarkRed")
		cube([20,20,3],center=true,$fn=50);
}

module Components() {
translate([6,25,3])
	rotate([90,0,0])
		EdisonMini();

translate([38,38,12])
	rotate([0,90,0])
		Battery();

translate([38,6,5])
		Powerboard();

translate([50,60,11])
	rotate([90,0,0])
		Audioboard();

translate([25,60,11])
	rotate([90,0,0])
		Motorboard();
}

//Components();

union() {
Platform();
translate([0,0,-0.5])
FurbyBase();
translate([0,0,8])
	FurbyWall();
EdisonMounts();
ModuleMounts();
FurbyPivot();
}
	
