//ltn = true;
//ltnChain = -1;
randomize();
maxhp = 0.5;
hp = 0.5;
maxspeed = 3;
damage = 1;
spr_main = spr_zomb2;
spr_hurt = spr_zombWhite;
depth = 10;

pt_fire=part_type_create();
part_type_shape(pt_fire,2);
part_type_size(pt_fire,0.20,0.30,-0.01,0.10);
part_type_scale(pt_fire,0.6,0.6);
part_type_orientation(pt_fire,0,0,0,0,0);
part_type_direction(pt_fire,0,360,0,0);
part_type_speed(pt_fire,0.50,1.50,-0.03,0);
part_type_gravity(pt_fire,0,270);
part_type_color3(pt_fire,255,33023,12632256);
part_type_alpha3(pt_fire,1,0.60,0.20);
part_type_blend(pt_fire,1);
part_type_life(pt_fire,10,20);

pt_die=part_type_create();
part_type_shape(pt_die,2);
part_type_size(pt_die,0.60,0.60,-0.02,0);
part_type_scale(pt_die,0.75,0.75);
part_type_orientation(pt_die,0,0,10,90,0);
part_type_direction(pt_die,0,360,0,0);
part_type_speed(pt_die,10,15,-0.2,0);
part_type_gravity(pt_die,0,270);
part_type_color3(pt_die,9568145,4652870,65280);
part_type_alpha3(pt_die,1,0.60,0.20);
part_type_blend(pt_die,1);
part_type_life(pt_die,25,75);

pt_explode=part_type_create();
part_type_shape(pt_explode,6);
part_type_size(pt_explode,0.3,0.6,0.175,0);
part_type_scale(pt_explode,0.70,1);
part_type_orientation(pt_explode,0,360,0,5,0);
part_type_direction(pt_explode,0,360,0,0);
part_type_speed(pt_explode,0.50,1,0,0);
part_type_gravity(pt_explode,0,270);
part_type_color3(pt_explode,16777215,65280,32768);
part_type_alpha3(pt_explode,1,0.50,0);
part_type_blend(pt_explode,1);
part_type_life(pt_explode,20,40);

pt_spawn=part_type_create();
part_type_shape(pt_spawn,6);
part_type_size(pt_spawn,0.10,0.10,0.50,0);
part_type_scale(pt_spawn,1,1);
part_type_orientation(pt_spawn,0,0,0,0,0);
part_type_direction(pt_spawn,0,360,0,0);
part_type_speed(pt_spawn,0,0,0,0);
part_type_gravity(pt_spawn,0,270);
part_type_color3(pt_spawn,65280,65280,65280);
part_type_alpha3(pt_spawn,1,0.50,0);
part_type_blend(pt_spawn,1);
part_type_life(pt_spawn,15,15);

if (object_index == obj_chomp) {
    part_type_color3(pt_die,c_white,c_red,c_maroon);
    part_type_color3(pt_explode,c_white,c_red,c_maroon);
    part_type_color3(pt_spawn,c_red,c_red,c_red);
    maxhp = 0.5;
    damage = 0.5;
    spr_main = spr_chomp2;
    spr_hurt = spr_chompWhite;
}
else if (object_index == obj_zomb) {
    //effect_create_above(ef_ellipse, x, y, 2, c_green);
    part_particles_create(ps,x,y,pt_spawn,1);
}
else if (object_index == obj_blargh) {
    part_type_color3(pt_die,c_white,c_yellow,c_yellow);
    part_type_color3(pt_explode,c_white,c_yellow,c_yellow);
    part_type_color3(pt_spawn,c_yellow,c_yellow,c_yellow);
    spr_main = spr_blargh;
    spr_hurt = spr_blarghWhite;
    maxhp = 3.5;
    damage = 2;
    splatColor = c_yellow;
}
else if (object_index == obj_shade) {
    part_type_color3(pt_die,c_white,c_purple,c_purple);
    part_type_color3(pt_explode,c_white,c_purple,c_purple);
    part_type_color3(pt_spawn,c_purple,c_purple,c_purple);
    spr_main = spr_shade2;
    spr_hurt = spr_shadeWhite;
    maxhp = 1.5;
    damage = 0.1;
}
else if (object_index == obj_glob) {
    maxhp = 1;
    damage = 1;
    spr_main = spr_glob2;
    spr_hurt = spr_globWhite2;
}
else if (object_index == obj_root) {
    maxhp = 2.5;
    damage = 0.75;
    spr_main = spr_root;
    spr_hurt = spr_rootWhite;
    image_speed = 0;
}

part_particles_create(ps,x,y,pt_spawn,1);

hp = maxhp;

image_alpha = 0.4;
da = 0.01;
fullSpawn = false;
fire = false;
fireTimer = -1;
fireTimerCap = room_speed * 2;
