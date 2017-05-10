module buffers(pos,diam) {
    gap = 0.5;
    w=47 + gap + diam;
    translate([pos,w/2,(diam/2)-0.2])
        rotate([0,90,0])
            rotate([0,0,360/16])
                cylinder(d=diam,h=25,$fn=8);
    translate([pos,-w/2,(diam/2)-0.2])
        rotate([0,90,0])
            rotate([0,0,360/16])
                cylinder(d=diam,h=25,$fn=8);
}

/*
translate([10,0,0])
    cube([45,45,45],center=true);
buffers(0,8);
*/