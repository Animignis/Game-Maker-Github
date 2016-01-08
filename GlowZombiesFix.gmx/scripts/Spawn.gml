var bound_xoff = argument0;
var bound_yoff = argument1;
var bound_l = argument2;
var bound_r = argument3;
var bound_up = argument4;
var bound_down = argument5;
var obj = argument6;

if (obj != -1) {
    var xx, yy, bnd_l, bnd_r, bnd_up, bnd_down;
    bnd_l = obj_playerRespawn.xx - view_wview*0.5 - bound_xoff;
    bnd_r = obj_playerRespawn.xx + view_wview*0.5 + bound_xoff;
    bnd_up = obj_playerRespawn.yy - view_hview*0.5 - bound_yoff;
    bnd_down = obj_playerRespawn.yy + view_hview*0.5 + bound_yoff;
    if (bnd_l < bound_l) {
        bnd_l = bound_l;
    }
    if (bnd_r > bound_r) {
        bnd_r = bound_r;
    }
    if (bnd_up < bound_up) {
        bnd_up = bound_up;
    }
    if (bnd_down > bound_down) {
        bnd_down = bound_down;
    }
    do {
    xx = random_range(bnd_l, bnd_r);
    yy = random_range(bnd_up, bnd_down);
    } until (!collision_circle(xx, yy, 64, obj_wall, false, true)
        && !collision_circle(xx, yy, 256, obj_player, false, true));
    var inst = instance_create(xx, yy, obj);
    return inst;
}
return noone;
