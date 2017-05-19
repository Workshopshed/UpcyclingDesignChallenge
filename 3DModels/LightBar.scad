include <bumper.scad>;

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
	thickness = 30.5;
    
    difference() {
    
        union() {
            intersection() {
                translate([-30,-bumpwidth/2,0])
                cube([30,bumpwidth,8+thickness]);

                translate([350,0,0])
                difference() {
                    cylinder(h=thickness+10,r=380,$fn=400);
                    translate([0,0,-1])
                        cylinder(h=thickness+10,r=374,$fn=400);
                }
            }
            
            translate([-21,0,3])
                cube([6,40,6],center=true);
               
            //Mounting points
            w2 = 47;
            thickness2 = 9;
            translate([-18,-(w2/2 + 4),-1 + thickness + thickness2/2])
                cube([16,9,thickness2],center=true);
            translate([-18,(w2/2+4),-1 + thickness + thickness2/2])
                cube([16,9,thickness2],center=true);
            translate([-22,0,-1 + thickness + thickness2/2])
                cube([8,64,thickness2],center=true);    
            
            }
        translate([-15,0,-4])
            connectionholes();
            
        //Mounting buffers
        translate([-15,0,thickness]) 
            buffers(-8.5,7.5);
            
            
        translate([-30,0,15])
            scale([1,1,3])
            	color([0.85,0.85,0.85])
                plate();
            
        translate([-9,-42,-0.5+thickness/2])
            cube([30,32,30], center=true);
        translate([-20,-42,thickness/2])
            cube([30,30,16], center=true); 
            
        translate([-9,42,-0.5+thickness/2])
            cube([30,32,30], center=true);
        translate([-20,42,thickness/2])
            cube([30,30,16], center=true); 

    }
    

}

module plate() {
		cube([2,54,16],center=true);	
}

color([0.85,0.85,0.85])
    lightbar();

/*
translate([-27,35,15])
	lights();

translate([-27,-35,15])
	rotate([180,0,0])
		lights();

translate([-30,0,15])
	color("white")
        plate();

translate([-13,0,-1])
    rotate([180,0,0])
        bumper();

*/