var px = obj_player.x;
var py = obj_player.y;
//projection line length
var len = view_wview;
//list of line projections
var egpI = ds_priority_create();
ds_priority_copy(egpI, egp);

var egpK = ds_priority_create();

while(!ds_priority_empty(egpI)) {
    var i = ds_priority_delete_min(egpI);
    var ix1 = eg[| i];
    var iy1 = eg[| i+1];
    var ix2 = eg[| i+2];
    var iy2 = eg[| i+3];
    var ipe = eg[| i+4];
    var ine = eg[| i+5];
    if (ine == -1) {
        var dir = point_direction(px, py, ix2, iy2);
        xx = px + lengthdir_x(len, dir);
        yy = py + lengthdir_y(len, dir);
        ds_priority_clear(egpK);
        ds_priority_copy(egpK, egpI);
        var k = 0;
        while(!ds_priority_empty(egpK)) {
            k = ds_priority_delete_min(egpK);
            var kx1 = eg[| k];
            var ky1 = eg[| k+1];
            var kx2 = eg[| k+2];
            var ky2 = eg[| k+3];
            var t = LineSegmentsIntersect(
                ix2, iy2, xx, yy,
                kx1, ky1, kx2, ky2);
            if (t > 0) {
                xx = ix2 + t * (xx - ix2);
                yy = iy2 + t * (yy - iy2);
                eg[| k+4] = ds_list_size(eg);
                eg[| k] = xx;
                eg[| k+1] = yy;
                eg[| i+5] = ds_list_size(eg);
                ds_list_add(eg, ix2, iy2, xx, yy, i, k);
                break;
            }
        }
    }
    if (ipe == -1) {
        var dir = point_direction(px, py, ix1, iy1);
        xx = px + lengthdir_x(len, dir);
        yy = py + lengthdir_y(len, dir);
        
        ds_priority_clear(egpK);
        ds_priority_copy(egpK, egpI);
        var k = 0;
        while(!ds_priority_empty(egpK)) {
            k = ds_priority_delete_min(egpK);
            var kx1 = eg[| k];
            var ky1 = eg[| k+1];
            var kx2 = eg[| k+2];
            var ky2 = eg[| k+3];
            var t = LineSegmentsIntersect(
                ix1, iy1, xx, yy,
                kx1, ky1, kx2, ky2);
            if (t != 0) {
                xx = ix1 + t * (xx - ix1);
                yy = iy1 + t * (yy - iy1);
                eg[| k+5] = ds_list_size(eg);
                eg[| k+2] = xx;
                eg[| k+3] = yy;
                eg[| i+4] = ds_list_size(eg);
                ds_list_add(eg, xx, yy, ix1, iy1, k, i);
                break;
            }
        }
    }
}

ds_priority_destroy(egpI);
ds_priority_destroy(egpK);
