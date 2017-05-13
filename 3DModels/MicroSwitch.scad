module microswitch() {
    w=15.5;
    l=27.5;
    h=10;
    rad=2;
    w1=(w-(2*rad))/2;
    l1=(l-(2*rad))/2;

    translate([0,0,-h/2]) {

    color([0.2,0.2,0.2]) {
    
        difference() {  
        
        hull() {
        for (a =[[w1,l1,0],[w1,-l1,0],[-w1,-l1,0],[-w1,l1,0]])
            {
                translate(a) {
                    cylinder(h=h,r=2,$fn=30);
                }
            }
        }
        microswitchholes();
        }
    }
    
    //Lever
    color("silver") {
    translate([-9,-4,(h-4)/2])
        rotate([0,0,5])
            cube([0.5,27,4]);
    translate([-9,-4,(h-4)/2])
        cube([3,0.5,4]);
    }
    
}
}

module microswitchholes() {
    //Mounting holes
    w=10.5;
    l=24.5;
    h=20;
    rad=1.5;
    w1=(w-rad)/2;
    l1=(l-rad)/2;
    translate([w1,l1,-2])
        cylinder(h=h,r=rad,$fn=30);
    translate([-w1,-l1,-2])
        cylinder(h=h,r=rad,$fn=30);
}

//microswitch();

