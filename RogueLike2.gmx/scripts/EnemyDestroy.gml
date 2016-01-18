var xx = x;
var yy = y;
var hue = color_get_hue(color);
with(obj_splatters) {
    AddSplat(xx, yy, hue);
}

Shake(20, 6);

numEnemies--;

part_type_color3(obj_partman.pt_explode_squares, color, color, color);
part_type_color3(obj_partman.pt_explode_enemy, color, color, color);

repeat(20) {
    var ran;
    ran=random(360);
    part_particles_create(ps,
        x+lengthdir_x(random(32),ran),
        y+lengthdir_y(random(32),ran),
        obj_partman.pt_explode_squares,1);
}

repeat (5)
{
    var ran;
    ran=random(360);
    
    part_particles_create(ps,
        x+lengthdir_x(random(32),ran),
        y+lengthdir_y(random(32),ran),
        obj_partman.pt_explode_enemy,1);
}

if (hp <= 0) {
    repeat(val) {
        instance_create(x, y, obj_point);
    }
}
