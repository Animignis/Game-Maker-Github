var cs = CELL_SIZE;
var x1 = floor(view_xview / cs);
var y1 = floor(view_yview / cs);
var x2 = ceil((view_xview + view_wview) / cs);
var y2 = ceil((view_yview + view_hview) / cs);

if (x1 < 0) { x1 = 0; }
if (x2 >= w) { x2 = w - 1; }
if (y1 < 0) { y1 = 0; }
if (y2 >= h) { y2 = h - 1; }

var xx;
var yy;

var px = playerX;
var py = playerY;
var pc = floor(px / cs);
var pr = floor(py / cs);

ds_list_clear(eg);
ds_priority_clear(egp);

for (var r = y1; r < y2; r++) {
    for (var c = x1; c < x2; c++) {
        var val = ds_grid_get(grid, c, r);
        xx = c * cs;
        yy = r * cs;
        switch(val) {
            default:
            if (c == x1) {
                AddLightEdgeVal(5, xx - cs, yy);
            }
            else if (c == x2 - 1) {
                AddLightEdgeVal(7, xx + cs, yy);
            }
            if (r == y1) {
                AddLightEdgeVal(8, xx, yy - cs);
            }
            else if (r == y2 - 1) {
                AddLightEdgeVal(6, xx, yy + cs);
            }
            break;
            
            case 0:
            break;
            
            case -1:
            if (c == x1) {
                AddLightEdgeVal(5, xx - cs, yy);
            }
            else if (c == x2 - 1) {
                AddLightEdgeVal(7, xx + cs, yy);
            }
            if (r == y1) {
                AddLightEdgeVal(8, xx, yy - cs);
            }
            else if (r == y2 - 1) {
                AddLightEdgeVal(6, xx, yy + cs);
            }
            break;
            case 1:
            if (py > (yy + cs + xx - px)) {
                AddLightEdgeVal(val, xx, yy);
            }
            if (c == x2 - 1) {
                AddLightEdgeVal(7, xx + cs, yy);
            }
            if (r == y2 - 1) {
                AddLightEdgeVal(6, xx, yy + cs);
            }
            break;
            
            case 2:
            if (py < (yy - xx) + px) {
                AddLightEdgeVal(val, xx, yy)
            }
            if (c == x2 - 1) {
                AddLightEdgeVal(7, xx + cs, yy);
            }
            if (r == y1) {
                AddLightEdgeVal(8, xx, yy - cs);
            }
            break;
            
            case 3:
            if (py < (yy + cs + xx) - px) {
                AddLightEdgeVal(val, xx, yy);
            }
            if (c == x1) {
                AddLightEdgeVal(5, xx - cs, yy);
            }
            if (r == y1) {
                AddLightEdgeVal(8, xx, yy - cs);
            }
            break;
            
            case 4:
            if (py > (yy - xx) + px) {
                AddLightEdgeVal(val, xx, yy);
            }
            if (c == x1) {
                AddLightEdgeVal(5, xx - cs, yy);
            }
            if (r == y2 - 1) {
                AddLightEdgeVal(6, xx, yy + cs);
            }
            break;
            
            case 5:
            if (c < pc) {
                AddLightEdgeVal(val, xx, yy);
            }
            break;
            
            case 6:
            if ( r > pr) {
                AddLightEdgeVal(val, xx, yy);
            }
            break;
            
            case 7:
            if (c > pc) {
                AddLightEdgeVal(val, xx, yy);
            }
            break;
            
            case 8:
            if (r < pr) {
                AddLightEdgeVal(val, xx, yy);
            }
            break;
        }
    }
}
