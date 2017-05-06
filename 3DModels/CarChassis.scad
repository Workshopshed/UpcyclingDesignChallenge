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
    translate([0,5,0])
        cube([5,70,5]);
    translate([8,5,0])
        rotate([0,0,90])
            cube([5,88.3,10]);
    translate([-75,5,0])
        cube([5,70,5]);
    translate([8,70,0])
        rotate([0,0,90])
            cube([5,88,10]);
    //Front
    translate([32,15,0])
        cube([10,50,10]);
    translate([6.56,9.38,0])
        rotate([0,0,-70])
            cube([5,40,10]);
    translate([44.16,56.92,0])
        rotate([0,0,70])
            cube([5,40,10]);
    //Front Buffers
    translate([60,54.92,0])
        rotate([0,0,90])
            cube([10,20,10]);
    translate([60,14.92,0])
        rotate([0,0,90])
            cube([10,20,10]);
    //Back
    translate([-108,10,0])
        cube([10,60,10]);
    translate([-80,5,0])
        rotate([0,0,82])
            cube([5,28.5,10]);
    translate([-108.25,71.1,0])
        rotate([0,0,-82])
            cube([5,28.5,10]);
    //Back Buffers
    translate([-105,58.92,0])
        rotate([0,0,90])
            cube([6.5,15,6.5]);
    translate([-105,14.92,0])
        rotate([0,0,90])
            cube([6.5,15,6.5]);
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
			cylinder(h=4,d=8,$fn=30);
			translate([0,0,4])
			cylinder(h=3,d1=8,d2=3,$fn=30);
			translate([0,0,10])
				cylinder(h=4,d=8,$fn=30);
		}
	}

}

module buffers() {
	w1 = 40;
	w2 = 44;
	translate([89,w1/2,5])
		bufferlarge();
	translate([89,-w1/2,5])
		bufferlarge();
	translate([-86,w2/2,3])
		buffersmall();
	translate([-86,-w2/2,3])
		buffersmall();
}

module bufferholes() {
	w1 = 40;
	w2 = 44;
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

module cutouts() {
	translate([42,-30,-2])
		cube([6,60,9]);
    translate([-38,-30,-2])
        cube([6,60,9]);
	translate([-68,-10,-2])
        cube([11,20,10]);
	translate([72,-9,-2])
        cube([11,18,10]);
	translate([-76.4,-35.3,-2])
		rotate([0,0,-35])
			cube([20,10,15]);
	translate([-70.4,26.9,-2])
		rotate([0,0,35])
			cube([20,10,15]);	
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
	//cutouts();
}