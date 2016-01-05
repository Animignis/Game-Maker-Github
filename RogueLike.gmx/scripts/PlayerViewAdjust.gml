var xx1 = ((x + mouse_x) * 0.5 - x) * 0.5 + x;
var yy1 = ((y + mouse_y) * 0.5 - y) * 0.5 + y;
view_xview = xx1 - view_wview * 0.5;
view_yview = yy1 - view_hview * 0.5;

var cs = CELL_SIZE;
//view_xview = clamp(view_xview, 0, obj_cave.w * cs + cs - view_wview);
//view_yview = clamp(view_yview, 0, obj_cave.h * cs + cs - view_hview);