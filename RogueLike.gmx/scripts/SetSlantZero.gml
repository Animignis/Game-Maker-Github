var r = argument0;
var c = argument1;

var nbs = CountAliveNbsNorm(r, c);
if (nbs >= 2) {
    if (c > 0 && r > 0 && c < w - 1 && r < h - 1
            && IsABlock(c - 1, r)
            && IsABlock(c, r - 1)
            && ds_grid_get(grid, c, r + 1) == -1
            && ds_grid_get(grid, c + 1, r) == -1) {
        //var block = instance_create(c * CELL_SIZE, r * CELL_SIZE, obj_block);
        //block.image_index = 1;
        ds_grid_set(grid, c, r, 1);
        //tile_add(tileSet, 40, 2, 32, 32, c * CELL_SIZE, r * CELL_SIZE, 1000);
        return true;
    }
    else if (c > 0 && r > 0 && c < w - 1 && r < h - 1
            && IsABlock(c - 1, r)
            && IsABlock(c, r + 1)
            && ds_grid_get(grid, c, r - 1) == -1
            && ds_grid_get(grid, c + 1, r) == -1) {
        //var block = instance_create(c * CELL_SIZE, r * CELL_SIZE, obj_block);
        //block.image_index = 2;
        ds_grid_set(grid, c, r, 2);
        //tile_add(tileSet, 78, 2, 32, 32, c * CELL_SIZE, r * CELL_SIZE, 1000);
        return true;
    }
    else if (c > 0 && r > 0 && c < w - 1 && r < h - 1 
            && IsABlock(c + 1, r)
            && IsABlock(c, r + 1)
            && ds_grid_get(grid, c, r - 1) == -1
            && ds_grid_get(grid, c - 1, r) == -1) {
        //var block = instance_create(c * CELL_SIZE, r * CELL_SIZE, obj_block);
        //block.image_index = 3;
        ds_grid_set(grid, c, r, 3);
        //tile_add(tileSet, 116, 2, 32, 32, c * CELL_SIZE, r * CELL_SIZE, 1000);
        return true;
    }
    else if (c > 0 && r > 0 && c < w - 1 && r < h - 1
            && IsABlock(c + 1, r)
            && IsABlock(c, r - 1)
            && ds_grid_get(grid, c, r + 1) == -1
            && ds_grid_get(grid, c - 1, r) == -1) {
        //var block = instance_create(c * CELL_SIZE, r * CELL_SIZE, obj_block);
        //block.image_index = 4;
        if (c == 169 && r == 123) {
            log("AHA! " + string(grid[# c, r]));
        }
        ds_grid_set(grid, c, r, 4);
        //tile_add(tileSet, 152, 2, 32, 32, c * CELL_SIZE, r * CELL_SIZE, 1000);
        return true;
    }
}
return false;
