var xx, yy, i;
var numLines = ds_list_size(lines);
for (i = 0; i < numLines; i++) {
    GridLineUpdate(i);
}
i = 0;
for (yy = 0; yy < grid_h; yy++) {
    for (xx = 0; xx < grid_w; xx++) {
        GridPointUpdate(i);
        i++;
    }
}
