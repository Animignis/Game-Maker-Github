image_angle = obj_player.image_angle;
direction = image_angle;
speed = 12;
depth = 200;

pt_die=part_type_create();
part_type_shape(pt_die,2);
part_type_size(pt_die,0.10,0.20,0,0);
part_type_scale(pt_die,0.5,0.5);
part_type_orientation(pt_die,0,360,1,0,0);
part_type_direction(pt_die,-25,25,0,0);
part_type_speed(pt_die,8,12,-0.40,0);
part_type_gravity(pt_die,0,270);
part_type_color3(pt_die,16777058,16776960,16711680);
part_type_alpha3(pt_die,1,0.60,0.20);
part_type_blend(pt_die,1);
part_type_life(pt_die,5,30);

pt_explode=part_type_create();
part_type_shape(pt_explode,6);
part_type_size(pt_explode,0.3,0.6,0.1,0);
part_type_scale(pt_explode,0.35,0.5);
part_type_orientation(pt_explode,0,360,0,5,0);
part_type_direction(pt_explode,0,360,0,0);
part_type_speed(pt_explode,0.50,1,0,0);
part_type_gravity(pt_explode,0,270);
part_type_color3(pt_explode,c_white,c_aqua,c_blue);
part_type_alpha3(pt_explode,1,0.50,0);
part_type_blend(pt_explode,1);
part_type_life(pt_explode,10,20);