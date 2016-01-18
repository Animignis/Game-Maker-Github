var x1 = argument0;
var y1 = argument1;
var x2 = argument2;
var y2 = argument3;
var val = ds_list_size(eg);
ds_list_add(eg, 
    x1, y1,
    x2, y2,
    -1, -1);
var cs = CELL_SIZE;
var px = playerX;
var py = playerY;
ds_priority_add(egp, val,
    point_distance(px, py, 
        (x1 + x2) / 2,
        (y1 + y2) / 2));
