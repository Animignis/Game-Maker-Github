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

minNum = 8;
maxNum = 12;

splats = ds_list_create();
depth = 5000;
//surf = surface_create(1024, 1024);

tiles = ds_queue_create();
tileLim = 10000;

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
    var t = tile_add(tile_bloodsplat, left, 0, 16, 16, xx, yy, depth);
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
    if (splats[| i+2] <= 0.7) {
        for (var r = 0; r < dataSize; r++) {
            ds_list_delete(splats, i + dataSize - 1 - r);
        }
    }
    
    ds_queue_enqueue(tiles, t);
    
}

var ovfl = ds_queue_size(tiles) - tileLim;
if (ovfl > 0) {
    repeat(1000) {
        var tile = ds_queue_dequeue(tiles);
        tile_delete(tile);
    }
}

#define AddSplat
/// AddSplat(x, y, hue);

var n = floor(random_range(minNum, maxNum));

var xx = argument0 - 16;
var yy = argument1 - 16;

var cdir = random(360);
var ddir = 360 / n;
var vdir = ddir * 0.1;
var rand = floor(random(4));
var color = make_color_hsv(argument2,
        (random(1) * 0.2 + 0.8) * 255,
        (random(1) * 0.6 + 0.4) * 255);
var t = tile_add(tile_bloodsplat, rand * 16 + rand * 4, 0, 16, 16, xx, yy, depth);
tile_set_scale(t, 2, 2);
tile_set_blend(t, color);
ds_queue_enqueue(tiles, t);

repeat (n) {
    var dir = cdir + random_range(-1 * vdir, vdir);
    var scale = random_range(1.25, 2.5);
    var spd = scale * random_range(14, 18);
    var f = random_range(spd / 8, spd / 2);
    var sizeChange = random_range(scale / 5, scale / 2);
    var alpha = 1;
    color = make_color_hsv(argument2,
        (random(1) * 0.2 + 0.8) * 255,
        (random(1) * 0.6 + 0.4) * 255);
    xx = argument0 - 8 * scale;
    yy = argument1 - 8 * scale;
    var len = speed + scale * 12;
    xx += lengthdir_x(len, dir);
    yy += lengthdir_y(len, dir);
    ds_list_add(splats, xx, yy, scale, dir, spd, f, sizeChange, alpha, color);
    cdir += ddir;
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