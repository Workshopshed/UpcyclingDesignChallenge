module battery() {
	color([0.2,0.2,1])
	hull() {
	cylinder(d=22,h=92,$fn=50);
	translate([0,25,0])
		cylinder(d=22,h=92,$fn=50);
	}
}

module clip() {
	gap = 0.2;

	difference() {
	rotate([0,90,0])
		hull() {
			cylinder(d=28,h=10,$fn=50);
			translate([0,25,0])
				cylinder(d=28,h=10,$fn=50);
			};
	translate([0,gap/2,0])		
	rotate([0,90,0])		
	hull() {
		cylinder(d=22+gap,h=92,$fn=50);
		translate([0,25,0])
			cylinder(d=22+gap,h=92,$fn=50);
		};
	translate([-1,-20,7])
	cube([94,60,20]);
	}	
}

module clips() {

union() {	
clip();

translate([0,2.5,-14])
	cube([92,20,3]);

translate([82,0,0])
	clip();
}
}


clips();

//rotate([0,90,0])
//	battery();