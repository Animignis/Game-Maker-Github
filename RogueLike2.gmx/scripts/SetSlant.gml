var r = argument0;
var c = argument1;

var nbs = CountAliveNbsNorm(r, c);
if (nbs >= 2) {
    if (c > 0 && r > 0 && ds_grid_get(grid, c - 1, r) == 0
            && ds_grid_get(grid, c, r - 1) == 0
            && ds_grid_get(grid, c, r + 1) != 0
            && ds_grid_get(grid, c + 1, r) != 0) {
        ds_grid_set(grid, c, r, 1);
        //tile_add(tileSet, 40, 2, 32, 32, c * CELL_SIZE, r * CELL_SIZE, 1000);
        return true;
    }
    else if (c > 0 && r < h - 1 && ds_grid_get(grid, c - 1, r) == 0
            && ds_grid_get(grid, c, r + 1) == 0
            && ds_grid_get(grid, c, r - 1) != 0
            && ds_grid_get(grid, c + 1, r) != 0) {
        ds_grid_set(grid, c, r, 2);
        //tile_add(tileSet, 78, 2, 32, 32, c * CELL_SIZE, r * CELL_SIZE, 1000);
        return true;
    }
    else if (c < w - 1 && r < h - 1 && ds_grid_get(grid, c + 1, r) == 0
            && ds_grid_get(grid, c, r + 1) == 0
            && ds_grid_get(grid, c, r - 1) != 0
            && ds_grid_get(grid, c - 1, r) != 0) {
        ds_grid_set(grid, c, r, 3);
        //tile_add(tileSet, 116, 2, 32, 32, c * CELL_SIZE, r * CELL_SIZE, 1000);
        return true;
    }
    else if (c < w - 1 && r > 0 && ds_grid_get(grid, c + 1, r) == 0
            && ds_grid_get(grid, c, r - 1) == 0
            && ds_grid_get(grid, c, r + 1) != 0
            && ds_grid_get(grid, c - 1, r) != 0
            ) {
        ds_grid_set(grid, c, r, 4);
        //tile_add(tileSet, 152, 2, 32, 32, c * CELL_SIZE, r * CELL_SIZE, 1000);
        return true;
    }
}
return false;
