var wob = 0;

if (wobTimer > 0) {
    wob = 1;
}

var dh = display_get_height();
var dw = display_get_width();

shader_set(sh_holo);
var vTimeHandle = shader_get_uniform(sh_holo, "vTime");
var vWobbleHandle = shader_get_uniform(sh_holo, "vIsWobbling");
var timeHandle = shader_get_uniform(sh_holo, "time");
shader_set_uniform_f(vTimeHandle, time);
shader_set_uniform_f(vWobbleHandle, wob);
shader_set_uniform_f(timeHandle, holoTime);
switch(mapMode) {
    case 1:
    draw_surface_ext(surf, 0, dh - h, 1, 1, 0, c_white, 0.85);
    break;
    
    case 2:
    draw_surface_ext(surf, 0, 0, dw/w, dh/h, 0, c_white, 0.6);
    break;
}
shader_reset();

draw_set_color(c_white);
draw_set_alpha(0.85);
var xx = floor(obj_player.x / CELL_SIZE);
var yy = display_get_height() - h + (obj_player.y / CELL_SIZE);
switch(mapMode) {
    case 0:
    xx = -10;
    yy = -10;
    break;
    
    case 2:
    xx = (obj_player.x / CELL_SIZE) * dw / w;
    yy = (obj_player.y / CELL_SIZE) * dh / h;
    break;
}
draw_circle(xx, yy, 2, false);
draw_set_color(c_lime);
var xy = ds_list_create();
with(obj_tower) {
    xx = floor(x / CELL_SIZE);
    yy = display_get_height() - obj_cave.h + (y / CELL_SIZE);
    switch(obj_cave.mapMode) {
        case 0:
        xx = -10;
        yy = -10;
        break;
        
        case 2:
        xx = (x / CELL_SIZE) * dw / obj_cave.w;
        yy = (y / CELL_SIZE) * dh / obj_cave.h;
        break;
    }
    ds_list_add(xy, xx, yy);
}

for (var i = 0; i < ds_list_size(xy); i += 2) {
    log(string(xy[| i]) + ", " + string(xy[| i + 1]));
    draw_circle(xy[| i], xy[| i+1], 2, false);
}
ds_list_destroy(xy);
draw_set_alpha(1);
