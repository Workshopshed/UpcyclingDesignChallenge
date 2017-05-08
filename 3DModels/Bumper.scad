include <buffers.scad>;
include <microswitch.scad>;

module switches() {

separation = 62/2;
rotation = 10;

translate([0,separation,0])  
rotate([0,0,-rotation])
    microswitch();
    
translate([0,-separation,0])  
    rotate([0,180,180+rotation])
        microswitch();

}

module switchholes() {

separation = 62/2;
rotation = 10;

translate([0,separation,0])  
rotate([0,0,-rotation])
    microswitchholes();
    
translate([0,-separation,15])  
    rotate([0,180,180+rotation])
        microswitchholes();

}

module bumper() {

thickness = 8;

difference() {

union() {
    translate([-6,-19,thickness/2])
        cube([20,12,thickness],center=true);
    translate([-6,19,thickness/2])
        cube([20,12,thickness],center=true);

    translate([3,-32,thickness/2])
    rotate([0,0,10])
        cube([6,29,thickness],center=true);

    translate([3,32,thickness/2])
    rotate([0,0,-10])
        cube([6,29,thickness],center=true);

    translate([5,0,0])

    intersection() {
        translate([-30,-60,0])
        cube([30,120,thickness+10]);

        translate([378,0,0])
        difference() {
            cylinder(h=thickness+8,r=401,$fn=200);
            translate([0,0,-1])
                cylinder(h=thickness+20,r=398,$fn=200);
        }
    }
}

//Mounting buffers
translate([1,0,0.5]) 
    buffers(-8,7,34);

//Cutouts to help bending
translate([-13,-25,-1])
    cylinder(h=22,d=5.5,$fn=30);

translate([-13,25,-1])
    cylinder(h=22,d=5.5,$fn=30);

translate([-2,0,-1])
    switchholes();
}



}

bumper();

//translate([-2,0,13])
//    switches();

