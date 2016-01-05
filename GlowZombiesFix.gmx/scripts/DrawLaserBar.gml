var lenLim = argument2;
var len = 0;
var dlen = 1;
var xx,yy,px,py;
px = argument0;
py = argument1;
xx = px;
yy = py;
var ldir = argument3;

while(len < lenLim) {
    xx = xx + lengthdir_x(dlen, ldir);
    yy = yy + lengthdir_y(dlen, ldir);
    len += dlen;
}
lsr_w += lsr_dw;
if (abs(lsr_w) > lsr_maxw) {
    lsr_w = lsr_maxw * sign(lsr_w);
    lsr_dw *= -1;
}

draw_set_alpha(0.1);
draw_line_width_color(px, py, xx, yy, 7 + abs(lsr_w), c_blue, c_blue);
draw_set_alpha(0.3);
draw_line_width_color(px, py, xx, yy, 5 + abs(lsr_w)*0.67, c_aqua, c_aqua);
draw_set_alpha(0.5);
draw_line_width_color(px, py, xx, yy, 3 + abs(lsr_w)*0.33, c_aqua, c_aqua);
draw_set_alpha(0.7);
draw_line_width_color(px, py, xx, yy, 1, c_white, c_white);
repeat (6)
{
var ran;
ran=random(360);

part_particles_create(ps,
xx+lengthdir_x(random(8),ran),
yy+lengthdir_y(random(8),ran),
pt_laser,1);
part_particles_create(ps,
px+lengthdir_x(random(8),ran),
py+lengthdir_y(random(8),ran),
pt_laser,1);
}
draw_set_alpha(1);