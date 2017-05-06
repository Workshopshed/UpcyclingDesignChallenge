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
			cylinder(d=30,h=10,$fn=50);
			translate([0,25,0])
				cylinder(d=30,h=10,$fn=50);
			};
	translate([-0.2,gap/2,0])		
	rotate([0,90,0])		
	hull() {
		cylinder(d=20+gap,h=92,$fn=50);
		translate([0,25,0])
			cylinder(d=20+gap,h=92,$fn=50);
		};
	translate([-1,-20,7])
	cube([94,60,20]);
     
    translate([-0.2,2.4,-15.1])
        scale([1.01,1.01,1.01])
            bar();
	}	
}

module bar() {
    difference() {
    cube([92,20,4.1]);

    translate([82.2,18,0])
        rotate([-30,0,0])
            cube([10,10,10]);
    translate([82.2,-9.8,0])
        rotate([-60,0,0])
            cube([10,10,10]);


    translate([-0.2,18,0])
        rotate([-30,0,0])
            cube([10,10,10]);
    translate([-0.2,-9.8,0])
        rotate([-60,0,0])
            cube([10,10,10]);
        
    translate([-1.2,-1,2.0])    
        cube([11,22,5]);   

    translate([82.2,-1,2.0])    
        cube([11,22,5]);  

    }
}

module assembled() {

clip();

translate([0,2.5,-14])
    bar();

translate([82,0,0])
	clip();

}


/*
assembled();

rotate([0,90,0])
	battery();
*/

clip(); //2 required
//bar();