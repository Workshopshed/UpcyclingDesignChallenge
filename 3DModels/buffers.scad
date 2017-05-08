module buffers(pos,d,w) {
    translate([pos,w/2,(d/2)-0.2])
        rotate([0,90,0])
            rotate([0,0,360/16])
                cylinder(d=6.5,h=25,$fn=8);
    translate([pos,-w/2,(d/2)-0.2])
        rotate([0,90,0])
            rotate([0,0,360/16])
                cylinder(d=6.5,h=25,$fn=8);
}