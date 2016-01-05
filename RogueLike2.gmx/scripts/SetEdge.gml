/*
5 = right
6 = left
7 = up
8 = down
*/
var r = argument0;
var c = argument1;
if (c < w - 1 && ds_grid_get(grid, c + 1, r) == -1) {
    ds_grid_set(grid, c, r, 5);
    return true;
}
if (r > 0 && ds_grid_get(grid, c, r - 1) == -1) {
    ds_grid_set(grid, c, r, 6);
    return true;
}
if (c > 0 && ds_grid_get(grid, c - 1, r) == -1) {
    ds_grid_set(grid, c, r, 7);
    return true;
}
if (r < h - 1 && ds_grid_get(grid, c, r + 1) == -1) {
    ds_grid_set(grid, c, r, 8);
    return true;
}
return false;