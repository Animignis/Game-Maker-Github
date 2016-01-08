//point 1
var x1 = argument0;
var y1 = argument1;
//point 2
var x2 = argument2;
var y2 = argument3;
//inner width
var iw = argument4;
//outter width
var ow = argument5;
//number of intermediary points
var n = argument6;
//static amount
var static = argument7;
//color
var c = argument8;
//alpha
var a = argument9;
var d = point_distance(x1, y1, x2, y2);
var angle = point_direction(x1, y1, x2, y2);
var seg = d / n;
var xx, yy;
xx[n - 1] = x2;
yy[n - 1] = y2;
xx[0] = x1;
yy[0] = y1;

var i;
for(i = 1; i < n-1; i++) {
    xx[i] = xx[i-1] + lengthdir_x(seg, angle);
    yy[i] = yy[i-1] + lengthdir_y(seg, angle);
}
for(i = 1; i < n-1; i++) {
    xx[i] += random(lengthdir_x(static, angle + 180 * random_range(-1, 1))) * choose(-1, 1);
    yy[i] += random(lengthdir_y(static, angle + 180 * random_range(-1, 1))) * choose(-1, 1);
}
draw_set_alpha(a);

for(i = 1; i < n; i++) {
/*
    draw_line_width_color(
        xx[i-1] + random(lengthdir_x(static, angle + 90 * random_range(-1, 1))) * choose(-1, 1), 
        yy[i-1] + random(lengthdir_y(static, angle + 90 * random_range(-1, 1))) * choose(-1, 1), 
        xx[i] + random(lengthdir_x(static, angle + 90 * random_range(-1, 1))) * choose(-1, 1), 
        yy[i] + random(lengthdir_y(static, angle + 90 * random_range(-1, 1))) * choose(-1, 1),
        iw, c, c);
        */
    draw_set_alpha(a);
    draw_line_width_color(
        xx[i-1],
        yy[i-1], 
        xx[i], 
        yy[i],
        iw, c, c);
    draw_set_alpha(a*0.5);
    draw_line_width_color(
        xx[i-1],
        yy[i-1], 
        xx[i], 
        yy[i],
        ow, c, c);
    
}
draw_set_alpha(1);
