//x1, y1, x2, y2, inner_w, outer_w, n, static, color, alpha
//draw_set_blend_mode(bm_add);
var x1 = x + lengthdir_x(barrel_len, image_angle);
var y1 = y + lengthdir_y(barrel_len, image_angle);
var x2 = mouse_x;
var y2 = mouse_y;
var xx1 = x + lengthdir_x(29, image_angle + 30);
var yy1 = y + lengthdir_y(29, image_angle + 30);
var xx2 = x + lengthdir_x(29, image_angle - 30);
var yy2 = y + lengthdir_y(29, image_angle - 30);
var angle = point_direction(x1, y1, x2, y2);
if (point_distance(x1, y1, x2, y2) > 0) {
    x2 = x1 + lengthdir_x(0, angle);
    y2 = y1 + lengthdir_y(0, angle);
}

DrawLightning(xx1, yy1, xx2, yy2, 1, 3, 4, 8, c_aqua, 0.8);
part_particles_create(ps,xx1,yy1,ptSpark,2);
part_particles_create(ps,xx2,yy2,ptSpark,2);
part_particles_create(ps,x1,y1,ptSpark,1);

if (ltn_enemy) {
    x2 = ltn_enemy.x;
    y2 = ltn_enemy.y;
}
part_particles_create(ps,x2,y2,ptSpark,3);
DrawLightning(
    x1, y1, x2, y2, 1, 4, 8, 8, c_aqua, 0.8);
DrawLightning(
    x1, y1, x2, y2, 1, 4, 8, 12, c_aqua, 0.8);
DrawLightning(
    x1, y1, x2, y2, 1, 4, 8, 8, c_aqua, 0.8);
draw_set_blend_mode(bm_normal);
draw_set_color(c_red);
//draw_circle(x1, y1, 16, false);
draw_set_color(c_white);
PlayerLtnChainRand();
