var wob = 0;

if (wobTimer > 0) {
    wob = 1;
}

var shader = sh_holo;

shader_set(shader);

var vTimeHandle = shader_get_uniform(shader, "vTime");
shader_set_uniform_f(vTimeHandle, time);

var vWobbleHandle = shader_get_uniform(shader, "vIsWobbling");
shader_set_uniform_f(vWobbleHandle, wob);

//var timeHandle = shader_get_uniform(shader, "time");
//shader_set_uniform_f(timeHandle, holoTime);

//var viewHandle = shader_get_uniform(shader, "view");
var view;
//view[0] = (view_xview + view_wview/2) / (ds_grid_width(obj_cave.grid) * CELL_SIZE);
//view[1] = -1 * (view_yview + view_hview/2) / (ds_grid_height(obj_cave.grid) * CELL_SIZE);
//view[0] = (obj_player.x) / (ds_grid_width(obj_cave.grid) * CELL_SIZE);
//view[1] = obj_player.y / (ds_grid_height(obj_cave.grid) * CELL_SIZE);
//shader_set_uniform_f_array(viewHandle, view);
