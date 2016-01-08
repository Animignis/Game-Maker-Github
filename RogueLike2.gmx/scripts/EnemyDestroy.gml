var xx = x;
var yy = y;
with(obj_splatters) {
    AddSplat(xx, yy, 80);
}

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
