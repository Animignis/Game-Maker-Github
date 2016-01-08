log("particle creation");
globalvar ps;
ps = part_system_create();
part_system_depth(ps, -1000);

// ENEMIES
pt_explode_squares=part_type_create();
part_type_shape(pt_explode_squares,2);
part_type_size(pt_explode_squares,0.60,0.60,-0.02,0);
part_type_scale(pt_explode_squares,0.75,0.75);
part_type_orientation(pt_explode_squares,0,0,10,90,0);
part_type_direction(pt_explode_squares,0,360,0,0);
part_type_speed(pt_explode_squares,10,15,-0.2,0);
part_type_gravity(pt_explode_squares,0,270);
part_type_color3(pt_explode_squares,9568145,4652870,65280);
part_type_alpha3(pt_explode_squares,1,0.60,0.20);
part_type_blend(pt_explode_squares,1);
part_type_life(pt_explode_squares,25,75);

pt_explode_enemy=part_type_create();
part_type_shape(pt_explode_enemy,6);
part_type_size(pt_explode_enemy,0.3,0.6,0.175,0);
part_type_scale(pt_explode_enemy,0.70,1);
part_type_orientation(pt_explode_enemy,0,360,0,5,0);
part_type_direction(pt_explode_enemy,0,360,0,0);
part_type_speed(pt_explode_enemy,0.50,1,0,0);
part_type_gravity(pt_explode_enemy,0,270);
part_type_color3(pt_explode_enemy,16777215,65280,32768);
part_type_alpha3(pt_explode_enemy,1,0.50,0);
part_type_blend(pt_explode_enemy,1);
part_type_life(pt_explode_enemy,20,40);

pt_spawn_enemy=part_type_create();
part_type_shape(pt_spawn_enemy,6);
part_type_size(pt_spawn_enemy,0.10,0.10,0.50,0);
part_type_scale(pt_spawn_enemy,1,1);
part_type_orientation(pt_spawn_enemy,0,0,0,0,0);
part_type_direction(pt_spawn_enemy,0,360,0,0);
part_type_speed(pt_spawn_enemy,0,0,0,0);
part_type_gravity(pt_spawn_enemy,0,270);
part_type_color3(pt_spawn_enemy,65280,65280,65280);
part_type_alpha3(pt_spawn_enemy,1,0.50,0);
part_type_blend(pt_spawn_enemy,1);
part_type_life(pt_spawn_enemy,15,15);

// PLAYER
pt_flash=part_type_create();
part_type_shape(pt_flash,9);
part_type_size(pt_flash,0.30,0.60,0,0);
part_type_scale(pt_flash,1,1);
part_type_orientation(pt_flash,0,360,1,0,0);
part_type_direction(pt_flash,-10,10,0,0);
part_type_speed(pt_flash,8,12,-0.40,0);
part_type_gravity(pt_flash,0,270);
part_type_color3(pt_flash,c_white,c_aqua,c_aqua);
part_type_alpha3(pt_flash,1,0.60,0.20);
part_type_blend(pt_flash,1);
part_type_life(pt_flash,5,20);

// BULLETS
pt_die_bullet=part_type_create();
part_type_shape(pt_die_bullet,2);
part_type_size(pt_die_bullet,0.15,0.30,0,0);
part_type_scale(pt_die_bullet,0.5,0.5);
part_type_orientation(pt_die_bullet,0,360,1,0,0);
part_type_direction(pt_die_bullet,-25,25,0,0);
part_type_speed(pt_die_bullet,8,12,-0.40,0);
part_type_gravity(pt_die_bullet,0,270);
part_type_color3(pt_die_bullet,16777058,16776960,16711680);
part_type_alpha3(pt_die_bullet,1,0.60,0.20);
part_type_blend(pt_die_bullet,1);
part_type_life(pt_die_bullet,5,30);

pt_explode_bullet=part_type_create();
part_type_shape(pt_explode_bullet,6);
part_type_size(pt_explode_bullet,0.3,0.6,0.14,0);
part_type_scale(pt_explode_bullet,0.35,0.5);
part_type_orientation(pt_explode_bullet,0,360,0,5,0);
part_type_direction(pt_explode_bullet,0,360,0,0);
part_type_speed(pt_explode_bullet,0.50,1,0,0);
part_type_gravity(pt_explode_bullet,0,270);
part_type_color3(pt_explode_bullet,c_white,c_aqua,c_blue);
part_type_alpha3(pt_explode_bullet,1,0.50,0);
part_type_blend(pt_explode_bullet,1);
part_type_life(pt_explode_bullet,10,20);

plist = ds_list_create();
ds_list_add(plist, 
    pt_spawn_enemy, pt_explode_enemy, pt_explode_squares, 
    pt_flash, 
    pt_die_bullet, pt_explode_bullet);
