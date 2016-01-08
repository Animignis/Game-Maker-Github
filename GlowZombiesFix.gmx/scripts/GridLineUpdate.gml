var index = argument0;
var line = ds_list_find_value(lines, index);

var p1 = ds_map_find_value(points, line[lp1]);
var p2 = ds_map_find_value(points, line[lp2]);

var len = point_distance(p1[px], p1[py], p2[px], p2[py]);
var tlx = line[ltlx];
var tly = line[ltly];
var tl = tlx + tly;

if (len > tl) {
    var angle = point_direction(p1[px], p1[py], p2[px], p2[py]);
    var lenx = lengthdir_x(len, angle);
    var leny = lengthdir_y(len, angle);
    var dx = ((p1[px] - p2[px]) / len) * (len - tl);
    var dy = ((p1[py] - p2[py]) / len) * (len - tl);
    var dvx = p1[pvx] - p2[pvx];
    var dvy = p1[pvy] - p2[pvy];
    var fx = line[lstf] * dx - dvx * line[ld];
    var fy = line[lstf] * dy - dvy * line[ld];
    
    GridPointApplyForce(line[lp1], -fx, -fy);
    GridPointApplyForce(line[lp2], fx, fy);
}

ds_list_replace(lines, index, line);
