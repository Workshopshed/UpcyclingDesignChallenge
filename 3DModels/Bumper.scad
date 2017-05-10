include <buffers.scad>;
include <microswitch.scad>;

module switches() {

separation = 72/2;
rotation = 5;

translate([0,separation,0])  
rotate([0,0,-rotation])
    microswitch();
    
translate([0,-separation,0])  
    rotate([0,180,180+rotation])
        microswitch();

}

module switchholes() {

separation = 72/2;
rotation = 5;

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
    w = 47;
    translate([-3,-(w/2 + 3.5),thickness/2])
        cube([16,8,thickness],center=true);
    translate([-3,(w/2+3.5),thickness/2])
        cube([16,8,thickness],center=true);

    translate([-8,0,thickness/2])
        cube([6,50,thickness],center=true);

    translate([-11,0,(thickness+10)/2])
        cube([12,10,thickness+6],center=true);

    translate([3,-(w/2 + 16),thickness/2])
    rotate([0,0,5])
        cube([6,29,thickness],center=true);

    translate([3,(w/2 + 16),thickness/2])
    rotate([0,0,-5])
        cube([6,29,thickness],center=true);

    translate([11,0,0])
        bumperbar(thickness);
    }


    //Mounting buffers
    translate([2,0,0.5]) 
        buffers(-8,7);

    //Cutouts to help bending
    translate([-15,-5,-1])
        cylinder(h=22,d=5.5,$fn=30);

    translate([-15,5,-1])
        cylinder(h=22,d=5.5,$fn=30);

    translate([-2,0,-1])
        switchholes();
    }
}

module bumperbar(thickness)
{
    bumpwidth = 130;
    
    intersection() {
        translate([-30,-bumpwidth/2,0])
        cube([30,bumpwidth,thickness+10]);

        translate([350,0,0])
        difference() {
            cylinder(h=thickness+8,r=380,$fn=200);
            translate([0,0,-1])
                cylinder(h=thickness+20,r=377,$fn=200);
        }
    }
}

/*
color("grey",0.2)
    translate([18.5,0,0])
        cube([45,45,45],center=true);
*/

bumper();

/*
translate([-2,0,13])
    switches();
*/
