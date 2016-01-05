c = floor(x / CELL_SIZE);
r = floor(y / CELL_SIZE);
/*
with(obj_cave) {
    GetLightEdges();
    SetPrevNextEdges();
    SetLightProjections();
}
draw_set_color(c_white);
var ls = obj_cave.eg;
draw_set_color(c_lime);
var i = ds_priority_find_min(obj_cave.egp);
var fx1 = ls[| i];
var fy1 = ls[| i+1];
var fx2 = ls[| i+2];
var fy2 = ls[| i+3];
var ne = ls[| i+5];
var nx = -1;
var ny = -1;
i = ne;
draw_line(fx1, fy1, fx2, fy2);
while(!(nx == fx1 && ny == fy1)) {
    var xx1 = ls[| i];
    var yy1 = ls[| i + 1];
    nx = ls[| i + 2];
    ny = ls[| i + 3];
    i = ls[| i + 5];
    draw_line(xx1, yy1, nx, ny);
}
//draw_primitive_end();
*/
draw_set_color(c_white);
draw_self();