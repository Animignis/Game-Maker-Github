//image_angle = obj_player.image_angle;
//direction = image_angle;
sx = 20*cos(obj_player.image_angle * pi / 180) + 0.5 * obj_player.fixspeed*cos(obj_player.dir * pi / 180);
sy = 20*sin(obj_player.image_angle * pi / 180) + 0.5 * obj_player.fixspeed*sin(obj_player.dir * pi / 180);
speed = sqrt(power(sx, 2) + power(sy, 2));
pwr = 0.34;

/*
pt_die=part_type_create();
part_type_shape(pt_die,0);
part_type_size(pt_die,2,2,-0.02,0);
part_type_scale(pt_die,1,1);
part_type_orientation(pt_die,0,0,10,90,1);
part_type_direction(pt_die,0,360,0,90);
part_type_speed(pt_die,5,5,0,0);
part_type_gravity(pt_die,0,270);
part_type_color3(pt_die,16776960,16777088,16777215);
part_type_alpha3(pt_die,1,0.60,0.20);
part_type_blend(pt_die,1);
part_type_life(pt_die,5,10);
*/

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

pt_fire = -1;

if (object_index == obj_wow) {
    part_type_scale(pt_explode, 1.4, 2);
    part_type_color3(pt_explode,c_blue,c_lime,c_green);
    part_type_scale(pt_die, 1.5, 2);
    part_type_color3(pt_die,c_blue,c_lime,c_green);
    sx = 11*cos(obj_player.image_angle * pi / 180) + 0.5 * obj_player.fixspeed*cos(obj_player.dir * pi / 180);
    sy = 11*sin(obj_player.image_angle * pi / 180) + 0.5 * obj_player.fixspeed*sin(obj_player.dir * pi / 180);
    speed = sqrt(power(sx, 2) + power(sy, 2));
}