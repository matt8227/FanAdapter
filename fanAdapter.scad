$fn = 100;

//-----------IMPORTANT-----------
buffer=0.02; //to help with removing skin effects openSCAD previews, set to 0 when rendering and/or exporting the STL file.
//--------------------------------

screw_hole_size = 4.9; //diameter of the screw hole
hole_distance = 7.5; //distance of the screw hole's center from the edge of the base

thickness = 1.5; //thickness of the parts
fan_size = 140; //size of the fan
filter_hole_diameter = 140; //diameter of the filter hole
insert_length = 70; //lenght of the insert into the filter hole

sealing_circle_length = 4; //extra diameter to be added onto the filter_hole_diameter to create a sealing circle (useful for filters with a foam sealant and/or when fan size is close to the filter hole diameter)

cone_steepness = 0.65;


cone = fan_size>filter_hole_diameter ? (fan_size-filter_hole_diameter)/cone_steepness : (filter_hole_diameter-fan_size)/cone_steepness;



difference()
{
	union()
	{
		//create base
		translate([0,0,0])
		cube([fan_size, fan_size, thickness]);
		
		//connecting cone
		translate([fan_size/2,fan_size/2,0])
        cylinder(h=cone, d1=fan_size, d2=filter_hole_diameter);
		
		//create sealing cylinder
		translate([fan_size/2,fan_size/2,cone])
		cylinder(h=thickness,d1=filter_hole_diameter+2*sealing_circle_length, d2=filter_hole_diameter+2*sealing_circle_length);
		
		//insert
		translate([fan_size/2,fan_size/2,cone])
		cylinder(h=insert_length,d=filter_hole_diameter);
	}
	//connecting cone
	translate([fan_size/2,fan_size/2,-buffer])
    cylinder(h=cone+2*buffer, d1=fan_size-(fan_size*1/30)+2*buffer, d2=filter_hole_diameter-2*thickness);
	
	//insert
	translate([fan_size/2,fan_size/2,cone-buffer])
    cylinder(h=insert_length+2*buffer,d=filter_hole_diameter-2*thickness);
	
	//create mounting holes
	translate([fan_size-hole_distance,fan_size-hole_distance,-buffer])
	cylinder(d=screw_hole_size,h=thickness+2*buffer);
	
	translate([hole_distance,fan_size-hole_distance,-buffer])
	cylinder(d=screw_hole_size,h=thickness+2*buffer);
	
	translate([fan_size-hole_distance,hole_distance,-buffer])
	cylinder(d=screw_hole_size,h=thickness+2*buffer);
	
	translate([hole_distance,hole_distance,-buffer])
	cylinder(d=screw_hole_size,h=thickness+2*buffer);
	
}
