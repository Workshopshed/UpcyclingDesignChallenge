include <EdisonMockups.scad>

module EdisonMounts() {
	difference() {
			EdisonMiniMountingHoles(3);
            scale([1,1,1.2])
                EdisonMiniMountingHoles(1);
	}
}	

module ModuleMounts() {
	translate([10,53,2])
		cube([58,3,4]);
	translate([13,62,2])
		cube([49,3,4]);	
}

module MiniUSB() {
    hull() {
    rotate([90,0,0])
        cylinder(d=3.5,h=10,$fn=30);
    translate([6,0,0])
    rotate([90,0,0])
        cylinder(d=3.5,h=10,$fn=30);
    }
}

module MotorCables() {
    hull() {
    rotate([90,0,0])
        cylinder(d=8,h=20,$fn=30);
    translate([10,0,0])
    rotate([90,0,0])
        cylinder(d=8,h=20,$fn=30);
    }
}


module Platform() {
difference() {
   union() {
     difference() {
        translate([0,0,2])
        cube([85,90,32],center=true);
        //Hollow out
        translate([0,0,15])
        cube([81,86,38],center=true);

        //Battery hole
        translate([0,0,3])
            cube([81,52,28],center=true);

        }
        scale([1,1,2])
            translate([38,-42.5,-3.90])
                rotate([0,0,90])
                    EdisonMounts();

        scale([1,1,2])
        translate([8,-31,-3.90])
            rotate([0,0,90])
                EdisonMounts();
        
        translate([-42,34,-4])
            cube([25,10,3]);

        translate([-42,41.5,-4])
            cube([25,3,10]);

        }
    translate([-32,48,2])
        MiniUSB(); 
   
    //Chassis cutouts
        translate([51,0-35-0.25,-17])
            rotate([0,0,90])
                cube([5+0.5,100,10]);
        translate([51,65-35-0.25,-17])
            rotate([0,0,90])
                cube([5+0.5,100,10]); 
    
    //Cable Holes
    translate([-11,20,-4])
        rotate([90,0,0])
            MotorCables();    
    //Trim top    
    translate([-50,-50,14])
        cube([100,100,30]);
    
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

module LevelShifters() {
    difference() {
	color("DarkOliveGreen",0.8)
		cube([50,30,20],center=true,$fn=50);
    translate([-24,-14,-4])
	rotate([0,0,0])
            scale([1,1,3])
			EdisonMiniMountingHoles(1);
    }
}

module Components() {
translate([78,-5,2])
	rotate([0,0,90])
		EdisonMini();

translate([38,24,-8])
	rotate([0,90,0])
		Battery();

translate([12,72,-5])
		Powerboard();

translate([35,60,4])
	rotate([90,0,0])
		Audioboard();

translate([13,45,11])
	rotate([90,0,90])
		Motorboard();

translate([33,30,10])    
rotate([0,0,90])    
    LevelShifters();    
}

//translate([-40,-37,6])    
  //  Components();

Platform();




	
