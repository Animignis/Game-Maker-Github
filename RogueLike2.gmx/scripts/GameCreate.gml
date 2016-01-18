timeTimerCap = 4;
timeTimer = timeTimerCap;
AspectFix();
ViewControlInit();

global.win = false;

activeObjs = ds_list_create();
ds_list_add(activeObjs, obj_cave);
ds_list_add(activeObjs, obj_shader_set);
ds_list_add(activeObjs, obj_shader_reset);
ds_list_add(activeObjs, obj_splatters);
ds_list_add(activeObjs, obj_shot_pa);
ds_list_add(activeObjs, obj_trail);
ds_list_add(activeObjs, obj_player);
ds_list_add(activeObjs, obj_tower);
ds_list_add(activeObjs, obj_shake);
ds_list_add(activeObjs, obj_partman);
ds_list_add(activeObjs, obj_spawn);

cursor_sprite = spr_cursor;

TrailInit(30, 8, c_red, 0.5, true, true, mouse_x, mouse_y);
