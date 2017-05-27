include <EdisonMockups.scad>

module FurbyBase() {

linear_extrude(height = 8, center = true)
	import("FurbyBaseOutline.dxf");
}

module FurbyWall() {
difference() {
linear_extrude(height = 20, center = true)
	import("FurbyBaseOutline.dxf");

translate([4,4,0])
	scale([0.9,0.9,1.2])
		linear_extrude(height = 20, center = true)
			import("FurbyBaseOutline.dxf");

}
}

module Platform() {
difference() {	
	translate([39,36,-8])
	scale([1,1.05,1])
		cylinder(d=80,h=8,center=true,$fn=70);

    //Chassis cutouts
    translate([70,0+2,-17])
        rotate([0,0,90])
            cube([5,81.5+0.5,10]);
    translate([70,65+2,-17])
        rotate([0,0,90])
            cube([5,81.5+0.5,10]);
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
translate([8,22,3])
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

Components();

Platform();
translate([0,0,-0.5])
FurbyBase();
translate([0,0,8])
	FurbyWall();

	
