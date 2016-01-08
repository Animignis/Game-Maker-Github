var k = 0;
var n = 4;
var i = 0;
var numLines = ds_list_size(lines);
for (k = 0; k < n; k++) {
    draw_primitive_begin(pr_linelist);
    for (i = floor(numLines * k / n); i < floor(numLines * (k + 1) / n); i++) {
        var line = ds_list_find_value(lines, i);
        var xx = i mod grid_w;
        var yy = floor(i / grid_w);
        var a = line[lp1];
        var b = line[lp2];
        var p2 = ds_map_find_value(points, b);
        draw_vertex(p2[px], p2[py]);
    }
    draw_primitive_end();
}
