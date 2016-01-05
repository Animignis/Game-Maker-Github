var newGrid = ds_grid_create(w, h);
for (var r = 0; r < h; r++) {
    for (var c = 0; c < w; c++) {
        var nbs = CountAliveNbs(r, c);
        if (ds_grid_get(grid, c, r) == 0) {
            if (nbs < deathLim) {
                ds_grid_set(newGrid, c, r, -1);
            }
            else {
                ds_grid_set(newGrid, c, r, 0);
            }
        }
        else {
            if (nbs > birthLim) {
                ds_grid_set(newGrid, c, r, 0);
            }
            else {
                ds_grid_set(newGrid, c, r, -1);
            }
        }
    }
}

for (var r = 0; r < h; r++) {
    for (var c = 0; c < w; c++) {
        ds_grid_set(grid, c, r, ds_grid_get(newGrid, c, r));
    }
}
ds_grid_destroy(newGrid);