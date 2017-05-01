module Exhaust() {
	union()
	{
	translate([1.81,4.66, 0])
		rotate([-20,-90,0])
			cylinder(r1=1.5,r2=2.5,h=30, $fn=100);

	rotate_extrude(convexity = 10, angle=70, $fn=100)
		translate([5, 0, 0])
			circle(r = 1.5, $fn = 100);
	}
}

module Base() {
	gap = 0.2;
	difference() {
		//Base
		union() {
			difference() {
				cube([33,43,3]);
				translate([4+(gap/2),4+(gap/2),-1])
					cube([25-gap,35-gap,5]);	
			}
			//Tabs
			cube([9,11,3]);
			translate([24,33,0])
				cube([8,9,3]);
		}
		//Holes
		translate([6,7,0])
			cylinder(d=3.5,h=10,$fn=50);
		
		translate([33-6,43-7,0])
			cylinder(d=3.5,h=10,$fn=50);	
	}
}

module Manifold() {
	union() {
		Base();
		translate([33,11,6.5])
			rotate([90,90,0])
				Exhaust();
		translate([33,17,6.5])
			rotate([90,90,0])
				Exhaust();
		translate([33,23,6.5])
			rotate([90,90,0])
				Exhaust();
		translate([33,30,6.5])
			rotate([90,90,0])
				Exhaust();
		translate([0,11,6.5])
			rotate([-90,90,0])
				Exhaust();
		translate([0,17,6.5])
			rotate([-90,90,0])
				Exhaust();
		translate([0,23,6.5])
			rotate([-90,90,0])
				Exhaust();
		translate([0,30,6.5])
			rotate([-90,90,0])
				Exhaust();
	}
}

Manifold();