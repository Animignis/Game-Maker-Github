#define Splats
/*
    x
    y
    scale
    dir
    spd
    f (friction)
    ds (delta size)
*/

minNum = 12;
maxNum = 16;

splats = ds_list_create();

//surf = surface_create(1024, 1024);

#define SplatsStep
var size = ds_list_size(splats);

/*
if (!surface_exists(surf)) {
    surf = surface_create(1024, 1024);
}
*/

var dataSize = 9;
for (var i = ds_list_size(splats) - dataSize; i >= 0; i-= dataSize) {
    var xx          = splats[| i];
    var yy          = splats[| i+1];
    var scale       = splats[| i+2];
    var dir         = splats[| i+3];
    var spd         = splats[| i+4];
    var f           = splats[| i+5];
    var sizeChange  = splats[| i+6];
    var alpha       = splats[| i+7];
    var color       = splats[| i+8];
    splats[| i+4] -= f;    
    
    if (spd > 0) {
        alpha -= random_range(0.05, 0.1);
        splats[| i+7] = alpha;
    }
    
    splats[| i+2] -= sizeChange;
    var rand = floor(random(4))
    var left = rand * 16 + rand * 4;
    var t = tile_add(tile_bloodsplat, left, 0, 16, 16, xx, yy, 3000);
    tile_set_scale(t, scale, scale);
    //tile_set_alpha(t, alpha);
    tile_set_blend(t, color);
    
    /*
    surface_set_target(surf);
    draw_sprite_ext(spr_bloodsplat, 0,
        xx, yy, scale, scale, 0,
        c_white, alpha);
    surface_reset_target();
    */
    splats[| i] += lengthdir_x(spd, dir);
    splats[| i+1] += lengthdir_y(spd, dir);
    if (splats[| i+2] <= 0.2) {
        for (var r = 0; r < dataSize; r++) {
            ds_list_delete(splats, i + dataSize - 1 - r);
        }
    }
    
}

#define AddSplat
var n = floor(random_range(minNum, maxNum));

repeat (n) {
    var xx = argument0 - 5;
    var yy = argument1 - 5;
    var scale = random_range(0.8, 2.0);
    var dir = random(360);
    var spd = random_range(14, 22);
    var f = random_range(spd / 8, spd / 2);
    var sizeChange = random_range(scale / 10, scale / 3);
    var alpha = 1;
    var color = make_color_hsv(argument2,
        (random(1) * 0.2 + 0.8) * 255,
        (random(1) * 0.6 + 0.4) * 255);
    ds_list_add(splats, xx, yy, scale, dir, spd, f, sizeChange, alpha, color);
}

#define SplatsDraw
/*
if (surface_exists(surf)) {
    draw_surface_part(surf,
        view_xview, view_yview,
        view_wview, view_hview,
        0, 0);
}
*/