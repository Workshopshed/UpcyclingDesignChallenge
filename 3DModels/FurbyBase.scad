include <EdisonMockups.scad>

module FurbyBase() {

linear_extrude(height = 4, center = true)
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

FurbyBase();
translate([0,0,8])
	FurbyWall();