var x1 = floor(view_xview / CELL_SIZE);
var y1 = floor(view_yview / CELL_SIZE);
var x2 = ceil((view_xview + view_wview) / CELL_SIZE);
var y2 = ceil((view_yview + view_hview) / CELL_SIZE);

if (x1 < 0) { x1 = 0; }
if (x2 >= w) { x2 = w - 1; }
if (y1 < 0) { y1 = 0; }
if (x2 >= h) { x2 = h - 1; }

var cs = CELL_SIZE;
var xx;
var yy;

var px = obj_player.x;
var py = obj_player.y;
var pc = floor(px / cs);
var pr = floor(py / cs);

for (var r = y1; r < y2; r++) {
    for (var c = x1; c < x2; c++) {
        var val = ds_grid_get(grid, c, r);
        xx = c * cs;
        yy = r * cs;
        if (c < pc) {
            if (val == 5) {
                AddLightEdge(
                    xx + cs, yy + cs,
                    xx + cs, yy);
            }
            else if (r < pr) {
                if (val == 1) {
                    AddLightEdge(
                        xx, yy + cs,
                        xx + cs, yy);
                }
                else if (val == 8) {
                    AddLightEdge(
                        xx, yy + cs,
                        xx + cs, yy + cs);
                }
            }
        }
        else if (c > pc) {
            if (val == 7) {
                AddLightEdge(
                    xx + cs, yy,
                    xx + cs, yy + cs);
            }
            else if (r < pr) {
                if (val == 1) {
                    AddLightEdge(
                        xx + cs, yy,
                        xx, yy + cs);
                }
                else if (val == 2) {
                    AddLightEdge(
                        xx, yy,
                        xx + cs, yy + cs);
                }
            }
        }
    }
}

return ls;
