var r = argument0;
var c = argument1;
var count = 0;
for(var i=-1; i<2; i++){
    for(var j=-1; j<2; j++){
        var nr = r + i;
        var nc = c + j;
        var val = 1;
        if (i == 0 && j == 0) {
        }
        else if (nr < 0 || nc < 0 || nr >= h || nc >= w) {
            count += val;
        }
        else if (ds_grid_get(grid, nc, nr) == 0) {
            count += val;
        }
    }
}

return count;
