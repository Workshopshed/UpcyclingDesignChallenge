offset = 0.25;
$fn=50;

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

module body() {
    union() {
    hull() {
        forCuboid(8,3,6)
          {
          translate([1.6,0,3])
            sphere(r=4);
          translate([0,-2.1,2])
              rotate([0,90,0])
                 cylinder(d=8,h=4,center=true);
          cube([4,4,5],center=true);
          cube([4,4,5],center=true);
          translate([1.6,0,-3])
            sphere(r=4);
          translate([0,-2,-2])
              rotate([0,90,0])
                 cylinder(d=8,h=4,center=true);
          cube([4,4,4],center=true);
          cube([4,4,4],center=true);
        }
    }
    //Front diffuser
      rotate([0,0,-12])
      translate([-33,-6.5,-6])
      for (x = [13:20])
          for (z = [1:5])
          {
              translate([x*2.1,0,z*2])
                sphere(r=2);
          }
    } 
}
 

module led() {
    cylinder(d=5+offset,h=50);
    translate([0,0,7])
        cylinder(d=7,h=25);
    sphere(d=5+offset);
}


difference(){
        color("OrangeRed")
            body();
        rotate([0,90,90]) {
            translate([0,0,-5])
                led();
        //Screw holes
        translate([0,7,0])
            cylinder(d=2.2,h=20);
        translate([0,-7,0])
            cylinder(d=2.2,h=20);
        }
}



