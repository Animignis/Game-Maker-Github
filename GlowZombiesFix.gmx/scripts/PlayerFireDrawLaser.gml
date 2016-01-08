var lenLim = 1024;
var len = 0;
var dlen = 1;
var xx,yy,px,py;
px = x + lengthdir_x(barrel_len + 8, image_angle);
py = y + lengthdir_y(barrel_len + 8, image_angle);;
xx = px + lengthdir_x(dlen, image_angle);
yy = py + lengthdir_y(dlen, image_angle);
len += dlen;

lsr_w += lsr_dw;
if (abs(lsr_w) > lsr_maxw) {
    lsr_w = lsr_maxw * sign(lsr_w);
    lsr_dw *= -1;
}
var validTarget = false;
var target = noone;
do{
    xx = xx + lengthdir_x(dlen, image_angle);
    yy = yy + lengthdir_y(dlen, image_angle);
    len += dlen;
    target = collision_point(xx,yy,obj_enemy_pa, false, true);
    if (target != noone) {
        if (target.object_index == obj_glob) {
            if (target.jumping) {
                validTarget = false;
            }
            else {
                validTarget = true;
            }
        }
        else {
            validTarget = true;
        }
    }
}until (len >= lenLim || validTarget || collision_point(xx,yy,obj_wall,false,true));

if (target != noone) {
    xx += lengthdir_x(32, image_angle);
    yy += lengthdir_y(32, image_angle);
    if (target.object_index == obj_chomp) {
        if (lungeTimer > 0) {
            target.hp -= weapon_damage[5] * 1.5;
        }
        else {
            target.hp -= weapon_damage[5];
        }
    }
    else {
        target.hp -= weapon_damage[5];
    }
    //target.hp -= weapon_damage[5];
    lsr_enemy = target;
}
else {
    lsr_enemy = -1;
}

draw_set_alpha(0.4);
draw_line_width_color(px, py, xx, yy, 7 + abs(lsr_w), c_green, c_green);
draw_set_alpha(0.6);
draw_line_width_color(px, py, xx, yy, 5 + abs(lsr_w)*0.67, c_lime, c_lime);
draw_set_alpha(0.8);
draw_line_width_color(px, py, xx, yy, 3 + abs(lsr_w)*0.33, c_lime, c_lime);
draw_set_alpha(1);
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
