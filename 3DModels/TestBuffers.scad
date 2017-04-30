

module buffers() {
	translate([5,20,5])
		bufferlarge();
	translate([5,5,3])
		buffersmall();
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


difference() {
	union() {
    cube([8,27,10]);
	buffers();
	}
	translate([-5,5,3])
		rotate([0,90,0])
			cylinder(h=40,d=2.5,$fn=30);
	translate([-5,20,5])
		rotate([0,90,0])
			cylinder(h=40,d=2.5,$fn=30);	
}
	
