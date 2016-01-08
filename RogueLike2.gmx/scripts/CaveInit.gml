//randomize();
w = argument0;
h = argument1;
grid = ds_grid_create(w, h);
var fillRatio = argument2;
var numSteps = argument3;
deathLim = 3;
birthLim = 4;
reviveNum = 3;
var dim = max(w, h);
surf = surface_create(dim, dim);

cheeseThresh = floor(w * h / 6);

empty = ds_list_create(); // { c0, r0, c1, r1, c2, r2 ... }

//light edges
egp = ds_priority_create();
eg = ds_list_create();

/* Map Modes:
0 = no map
1 = mini map
2 = fullscreen map
*/
mapMode = 1;

tileSet = bk_tiles_cyan;

/*
-1 = empty
0 = square wall
1 = down-right
2 = up-right
3 = up-left
4 = down-left
*/

//initialize cave
for (var r = 0; r < h; r++) {
    for (var c = 0; c < w; c++) {
        if (random(1) <= fillRatio) {
            ds_grid_set(grid, c, r, 0);
        }
        else {
            ds_grid_set(grid, c, r, -1);
        }
    }
}

//make cave
for (var i = 0; i < numSteps; i++) {
    CaveGen();
}
//fill borders
for (var r = 0; r < h; r++) {
    ds_grid_set(grid, 0, r, 0);
    ds_grid_set(grid, w - 1, r, 0);
}
for (var c = 0; c < w; c++) {
    ds_grid_set(grid, c, 0, 0);
    ds_grid_set(grid, c, h - 1, 0);
}

//de-cheese
drain = ds_list_create();
fill = ds_list_create();
pgrid = ds_grid_create(w, h);
ds_grid_copy(pgrid, grid);
for (var r = 1; r < h - 1; r++) {
    for (var c = 1; c < w - 1; c++) {
        if (ds_grid_get(pgrid, c, r) == -1) {
            var count = CaveDeCheese(r, c);
            if (count > cheeseThresh) {
                for (var i = 0; i < ds_list_size(fill); i += 2) {
                    var cc = ds_list_find_value(fill, i);
                    var rr = ds_list_find_value(fill, i + 1);
                    ds_grid_set(grid, cc, rr, -1);
                }
            }
        }
        ds_list_clear(fill);
    }
}

ds_list_destroy(drain);
ds_list_destroy(fill);
ds_grid_destroy(pgrid);

//initialize player position, map surface, and tiles
/*
    -1= empty
    0 = non-edge whole wall
    1 = down-right slant
    2 = up-right slant
    3 = up-left slant
    4 = down-left slant
    5 = right edge wall
    6 = up edge wall
    7 = left edge wall
    8 = down edge wall
    9 = tower
*/
surface_set_target(surf);
draw_clear(c_purple);
draw_set_color(c_fuchsia);
log("drawing tiles");
for (var r = 0; r < h; r++) {
    for (var c = 0; c < w; c++) {
        var slant = false;
        if (ds_grid_get(grid, c, r) == 0) {
            draw_point(c, r);
            //tile_add(tileSet, 2, 2, 32, 32, c * CELL_SIZE, r * CELL_SIZE, 1000);
        }
        else if (ds_grid_get(grid, c, r) == -1) {
            slant = SetSlant(r, c);
        }
        if (slant) {
            draw_point(c, r);
        }
    }
}
var cs = CELL_SIZE;
log("setting zero edges");
for (var r = 0; r < h; r++) {
    for (var c = 0; c < w; c++) {
        var gval = ds_grid_get(grid, c, r);
        if (gval == 0) {
            //var t = tile_layer_find(1000, cs * c, cs * r);
            slant = SetSlantZero(r, c);
            if (!slant) {
                SetEdge(r, c);
            }
            else {
                //tile_delete(t);
            }
        }
        if (ds_grid_get(grid, c, r) == -1) {
            ds_list_add(empty, c);
            ds_list_add(empty, r);
        }
    }
}

var rand = floor(random(ds_list_size(empty) / 2)) * 2;
var c = empty[| rand];
var r = empty[| rand+1];
log("PLAYER: " + string(c) + ", " + string(r));
var halfCS = CELL_SIZE * 0.5;
instance_create(
    c * CELL_SIZE + halfCS,
    r * CELL_SIZE + halfCS,
    obj_player);
instance_create(
    c * CELL_SIZE + halfCS,
    r * CELL_SIZE + halfCS,
    obj_enemy);

var towerDistI = CELL_SIZE*200;
var towerDist = towerDistI;
var nt = 0;
repeat(10) {
    var fin = false;
    var xx = -1;
    var yy = -1;
    do {
        if (towerDist > 256) {
            towerDist -= CELL_SIZE;
        }
        rand = floor(random(ds_list_size(empty) / 2)) * 2;
        c = empty[| rand];
        r = empty[| rand+1];
        xx = c * CELL_SIZE + halfCS;
        yy = r * CELL_SIZE + halfCS;
        if (nt == 0) {
            break;
        }
        fin = true;
        with (obj_tower) {
            if (point_distance(x, y, xx, yy) <= towerDist) {
                fin = false;
                break;
            }
        }
    } until(fin);
    instance_create(xx, yy, obj_tower);
    ds_grid_set(grid, c, r, 9);
    ds_list_delete(empty, rand);
    ds_list_delete(empty, rand);
    nt++;
    towerDist = towerDistI;
}
ds_list_destroy(empty);

log("cave done");
draw_set_color(c_white);
surface_reset_target();

view_xview = obj_player.x;
view_yview = obj_player.y;
