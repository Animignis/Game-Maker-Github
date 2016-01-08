var xx = argument0;
var yy = argument1;
var c = floor(xx / CELL_SIZE);
var r = floor(yy / CELL_SIZE);
var ret = -1;
with(obj_cave) {
    ret = ds_grid_get(grid, c, r);
}
return ret;
