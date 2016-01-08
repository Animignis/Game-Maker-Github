image_angle = random(360);
da = 1/600;
c = c_yellow;
image_blend = c;


damage = 0.25;

pt_splat=part_type_create();
part_type_shape(pt_splat,pt_shape_spark);
part_type_size(pt_splat,0.50,1,-0.10,0);
part_type_scale(pt_splat,0.5,0.5);
part_type_orientation(pt_splat,0,0,5,0,0);
part_type_direction(pt_splat,0,360,10,10);
part_type_speed(pt_splat,1,1,0,0);
part_type_gravity(pt_splat,0,270);
part_type_color3(pt_splat,c,c,c_white);
part_type_alpha3(pt_splat,1,0.50,0);
part_type_blend(pt_splat,1);
part_type_life(pt_splat,10,15);
