offset = 0.25;
$fn=30;

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
    //Front diffuser
      rotate([0,0,-12])
      translate([-32,-3.5,-6])
      for (x = [13:19])
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
            translate([0,0,-2.3])
                led();
        //Screw holes
        translate([0,7,-3.5])
            cylinder(d=2.2,h=10);
        translate([0,-7,-3.5])
            cylinder(d=2.2,h=10);
        }
}



