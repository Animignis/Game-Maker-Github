globalvar ps;
ps = part_system_create();
part_system_depth(ps, -1000);

pt_flash=part_type_create();
part_type_shape(pt_flash,9);
part_type_size(pt_flash,0.30,0.60,0,0);
part_type_scale(pt_flash,0.5,0.5);
part_type_orientation(pt_flash,0,360,1,0,0);
part_type_direction(pt_flash,-10,10,0,0);
part_type_speed(pt_flash,8,12,-0.40,0);
part_type_gravity(pt_flash,0,270);
part_type_color3(pt_flash,c_white,c_aqua,c_aqua);
part_type_alpha3(pt_flash,1,0.60,0.20);
part_type_blend(pt_flash,1);
part_type_life(pt_flash,2,15);