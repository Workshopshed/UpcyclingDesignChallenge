module buffers(pos,diam,w) {
    translate([pos,w/2,(diam/2)-0.2])
        rotate([0,90,0])
            rotate([0,0,360/16])
                cylinder(d=diam,h=25,$fn=8);
    translate([pos,-w/2,(diam/2)-0.2])
        rotate([0,90,0])
            rotate([0,0,360/16])
                cylinder(d=diam,h=25,$fn=8);
}