module headlight() {
	//Simplified model
	cube([14,14,8],center=true);
}

module forCuboid(offsetx,offsety,offsetz) {
   
    for(i = [[-1,-1,-1,0],
             [1,-1,-1,1],
             [1,1,-1,2],
             [-1,1,-1,3],
             [-1,-1,1,4],
             [1,-1,1,5],
             [1,1,1,6],
             [-1,1,1,7]])
        {
            translate([offsetx*i[0],offsety*i[1],offsetz*i[2]])
            if (i[3] > $children-1){
                children(0);
            } else {
                children(i[3]);
            }
        }
}

module indicator() {
	//Simplfied model
    hull() {
        rad=3;
        forCuboid(8,1,6)
          {
          translate([1.6,0,3])
            sphere(r=rad);
          translate([0,-2,1.3])
              rotate([0,90,0])
                 cylinder(r=rad,h=3,center=true);
          cube([3,3,3],center=true);
          cube([3,3,3],center=true);
          translate([1.6,0,-3])
            sphere(r=rad);
          translate([0,-2,-1.3])
              rotate([0,90,0])
                 cylinder(r=rad,h=3,center=true);
          cube([3,3,3],center=true);
          cube([3,3,3],center=true);
        }
    }
}

module lights() {
	translate([4,-7,15])
		rotate([0,90,0])
			pcb();
	rotate([0,-90,0])
		color("grey",0.9)
			headlight();
	translate([1.5,17,0])
		rotate([0,0,-90])
			color("orange",0.9)
				indicator();
	
}


module pcb() {
	color("black")
		cube([30,27,2]);
}

module lightbar()
{	
	w=130;
    bumpwidth = 130;
	thickness = 30;
    
    intersection() {
        translate([-30,-bumpwidth/2,0])
        cube([30,bumpwidth,thickness]);

        translate([350,0,0])
        difference() {
            cylinder(h=thickness+10,r=380,$fn=200);
            translate([0,0,-1])
                cylinder(h=thickness+10,r=370,$fn=200);
        }
    }
}

module plate() {
	color("white")
		cube([2,54,16],center=true);	
}

lightbar();

translate([-27,35,15])
	lights();

translate([-27,-35,15])
	rotate([180,0,0])
		lights();

translate([-30,0,15])
	plate();