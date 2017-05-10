module roundedsquare(l,r,h) {
	l2 = l/2-r;
	hull() {
	translate([l2,l2,0])
		cylinder(d=r*2,h=h,center=true,$fn=20);
	translate([-l2,l2,0])
		cylinder(d=r*2,h=h,center=true,$fn=20);
	translate([l2,-l2,0])
		cylinder(d=r*2,h=h,center=true,$fn=20);
	translate([-l2,-l2,0])
		cylinder(d=r*2,h=h,center=true,$fn=20);
	}
}

module headlight() {
	difference() {
	cube([14,14,8],center=true);
	translate([0,0,-0.5])
		cube([12.5,12.5,8.5],center=true);
		
	}

	for(s = [2 : 1.75 : 15])
	{
		translate([0,0,4.5])
		difference() {
		roundedsquare(s,0.5,1);
			translate([0,0,-0.5])
				roundedsquare(s-1,0.5,2);
		}
	}
}


headlight();