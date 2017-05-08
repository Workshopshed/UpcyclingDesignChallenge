module microswitch() {
    w=11;
    l=25;
    h=10;

    translate([0,0,-h/2]) {

    color([0.2,0.2,0.2]) {
    
        difference() {  
        
        hull() {
        for (a =[[w/2,l/2,0],[w/2,-l/2,0],[-w/2,-l/2,0],[-w/2,l/2,0]])
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
    translate([10.5/2,24.5/2,-2])
        cylinder(h=20,r=1.5,$fn=30);
    translate([-10.5/2,-24.5/2,-2])
        cylinder(h=20,r=1.5,$fn=30);
}

//microswitch();

