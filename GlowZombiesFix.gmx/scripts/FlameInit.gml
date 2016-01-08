event_inherited();

sx = 8*cos(obj_player.image_angle * pi / 180) + 0.5 * obj_player.fixspeed*cos(obj_player.dir * pi / 180);
sy = 8*sin(obj_player.image_angle * pi / 180) + 0.5 * obj_player.fixspeed*sin(obj_player.dir * pi / 180);
speed = sqrt(power(sx, 2) + power(sy, 2));

pwr = 0.025;
decel = 0.25;

size = 24;
sizeFactor = 0.1;
sizeFactorAdjust = 0.02;
sizeFactorAdjustCap = 1;

deathTimer = room_speed * 8;

pt_fire=part_type_create();
part_type_shape(pt_fire,2);
part_type_size(pt_fire,0.20,0.30,-0.01,0.10);
part_type_scale(pt_fire,0.5,0.5);
part_type_orientation(pt_fire,0,0,0,0,0);
part_type_direction(pt_fire,0,360,0,0);
part_type_speed(pt_fire,0.50,1.50,-0.03,0);
part_type_gravity(pt_fire,0,270);
part_type_color3(pt_fire,255,33023,12632256);
part_type_alpha3(pt_fire,1,0.60,0.20);
part_type_blend(pt_fire,1);
part_type_life(pt_fire,5,15);

part_type_color3(pt_explode,c_red,c_orange,c_yellow);
