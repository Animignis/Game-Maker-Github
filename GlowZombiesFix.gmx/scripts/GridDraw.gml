var i;
var numLines = ds_list_size(lines);
//draw_text(0,0,string(fps_real));

var lbor = view_xview - s;
var rbor = view_xview + view_wview + s;
var ubor = view_yview - s;
var dbor = view_yview + view_hview + s;

if (surface_exists(gridSurf)) {
    if (alarm[0] == 1) {
        surface_set_target(gridSurf);
        draw_clear_alpha(0, 0);
        draw_set_color(make_color_rgb(0, 170, 255));
        draw_set_alpha(0.9);
        /*
        for (i = 0; i < numLines; i++) {
            var line = ds_list_find_value(lines, i);
            var a = line[lp1];
            var b = line[lp2];
            //if (a < numCells) {
                var p1 = ds_map_find_value(points, line[lp1]);
                var p2 = ds_map_find_value(points, line[lp2]);
                //draw_circle(p1[px], p1[py], 6, false);
                //draw_circle(p2[px], p2[py], 4, false);
                //draw_line(p1[px], p1[py], p2[px], p2[py]);
            //}
        }
        */
        
        var k = 0;
        var n = 10;
        for (k = 0; k < n; k++) {
            draw_primitive_begin(pr_linelist);
            for (i = floor(numLines * k / n); i < floor(numLines * (k + 1) / n); i++) {
                var line = ds_list_find_value(lines, i);
                var a = line[lp1];
                if (a < numCells) {
                    var b = line[lp2];
                    var p1 = ds_map_find_value(points, a);
                    var p2 = ds_map_find_value(points, b);
                    var p1x = p1[px];
                    var p1y = p1[py];
                    var p2x = p2[px];
                    var p2y = p2[py];
                    if (p1x >= lbor && p1x <= rbor && p1y >= ubor && p1y <= dbor
                            && p2x >= lbor && p2x <= rbor && p2y >= ubor && p2y <= dbor) {
                        draw_vertex(p1[px], p1[py]);
                        draw_vertex(p2[px], p2[py]);
                    }
                }
            }
            draw_primitive_end();
        }
        surface_reset_target();
    }
    draw_surface(gridSurf, 0, 0);
}
else {
    gridSurf = surface_create(1024, 1024)
}
//draw_surface_stretched(gridSurf, 0, 0, 640, 640);
