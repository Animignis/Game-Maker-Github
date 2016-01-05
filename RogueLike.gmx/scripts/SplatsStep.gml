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

minNum = 10;
maxNum = 10;

splats = ds_list_create();

surf = surface_create(1024, 1024);

#define SplatsStep
var size = ds_list_size(splats);

if (!surface_exists(surf)) {
    surf = surface_create(1024, 1024);
}

for (var i = ds_list_size(splats) - 8; i >= 0; i-= 8) {
    var xx          = splats[| i];
    var yy          = splats[| i+1];
    var scale       = splats[| i+2];
    var dir         = splats[| i+3];
    var spd         = splats[| i+4];
    var f           = splats[| i+5];
    var sizeChange  = splats[| i+6];
    var alpha       = splats[| i+7];
    
    if (spd > 0) {
        alpha -= random_range(0.05, 0.1);
        splats[| i+7] = alpha;
    }
    tile_add(tile_bloodsplat, 0, 0, 10, 10, xx, yy, 2000);
    /*
    surface_set_target(surf);
    draw_sprite_ext(spr_bloodsplat, 0,
        xx, yy, scale, scale, 0,
        c_white, alpha);
    surface_reset_target();
    */
    if (scale <= 0) {
        for (var r = 0; r < 8; r++) {
            ds_list_delete(splats, i + 7 - r);
        }
    }
    
}

#define AddSplat
var n = floor(random_range(minNum, maxNum));

repeat (n) {
    var xx = argument0 - 5;
    var yy = argument1 - 5;
    var scale = random_range(0.33, 1);
    var dir = random(360);
    var spd = random_range(3, 12);
    var f = random_range(spd / 8, spd / 2);
    var sizeChange = random_range(scale / 10, scale / 3);
    var alpha = 1;
    ds_list_add(splats, xx, yy, scale, dir, spd, f, sizeChange, alpha);
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
