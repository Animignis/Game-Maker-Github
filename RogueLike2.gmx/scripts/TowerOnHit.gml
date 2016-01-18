var dmg = argument0;
hp -= dmg;
hurt = 4;

Shake(5, 2);

if (hp <= 0) {
    Shake(30, 10);
    var c = floor(x / CELL_SIZE);
    var r = floor(y / CELL_SIZE);
    with(obj_cave) {
        ds_list_add(empty, c, r);
        ds_grid_set(grid, c, r, -1);
    }
    var xx = c * CELL_SIZE - CELL_SIZE * 1.5;
    var yy = r * CELL_SIZE - CELL_SIZE * 1.5;
    var decal = tile_add(bk_tower_destroy,
        0, 0, 60, 60,
        xx, yy, 4000);
    tile_set_scale(decal, 3, 3);
    tile_set_blend(decal, color);
    
    instance_destroy();
}
