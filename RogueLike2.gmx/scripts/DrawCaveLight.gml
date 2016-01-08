GetLightEdges();
SetPrevNextEdges();
SetLightProjections();
var color = c_navy;
var ls = eg;
var i = ds_priority_find_min(egp);
var fx1 = ls[| i];
var fy1 = ls[| i+1];
var fx2 = ls[| i+2];
var fy2 = ls[| i+3];
var ne = ls[| i+5];
var nx = -1;
var ny = -1;
i = ne;
var len = view_wview;
var dir, prx, pry;
var oldDepth = depth;
depth = 0;
draw_primitive_begin(pr_trianglefan);
var ss = SURF_SIZE/2;
var offw = ss - view_wview/2;
var offh = ss - view_hview/2;
var vx = view_xview - offw;
var vy = view_yview - offh;
draw_vertex(obj_player.x - vx, obj_player.y - vy);
dir = point_direction(
        obj_player.x, obj_player.y, fx1, fy1);
prx = obj_player.x + lengthdir_x(len, dir);
pry = obj_player.y + lengthdir_y(len, dir);
draw_set_color(color);
draw_set_blend_mode(bm_normal);
draw_line_width(
    fx1 - vx, fy1 - vy, prx - vx, pry - vy, 2);
dir = point_direction(
        obj_player.x, obj_player.y, fx2, fy2);
prx = obj_player.x + lengthdir_x(len, dir);
pry = obj_player.y + lengthdir_y(len, dir);
draw_line_width(
    fx2 - vx, fy2 - vy, prx - vx, pry - vy, 2);
draw_set_blend_mode(bm_subtract);
draw_set_color(c_white);
draw_vertex(fx1 - vx, fy1 - vy);
draw_vertex(fx2 - vx, fy2 - vy);
draw_set_alpha(1);
var count = 0;
var thresh = 2000;
while(!(nx == fx1 && ny == fy1) && count < thresh) {
    var xx1 = ls[| i];
    var yy1 = ls[| i + 1];
    nx = ls[| i + 2];
    ny = ls[| i + 3];
    draw_vertex(nx - vx, ny - vy);
    dir = point_direction(
        obj_player.x, obj_player.y, nx, ny);
    prx = obj_player.x + lengthdir_x(len, dir);
    pry = obj_player.y + lengthdir_y(len, dir);
    draw_set_color(color);
    draw_set_blend_mode(bm_normal);
    draw_line_width(
        nx - vx, ny - vy, prx - vx, pry - vy, 2);
    draw_set_blend_mode(bm_subtract);
    draw_set_color(c_white);
    i = ls[| i + 5];
    count++;
}
draw_primitive_end();

draw_set_blend_mode(bm_normal);

depth = oldDepth;
