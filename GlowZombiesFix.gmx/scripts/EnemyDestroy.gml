PlaySound(choose(snd_explode1,snd_explode2,snd_explode3));
var gx = x;
var gy = y;
with(obj_grid) {
    GridImplode(gx, gy, 200, 200);
}

if (instance_number(obj_player) > 0) {
    if (id == obj_player.ltn_enemy) {
        obj_player.ltn_enemy = -1;
    }
}

repeat(20) {
var ran;
ran=random(360);
part_particles_create(ps,
x+lengthdir_x(random(32),ran),
y+lengthdir_y(random(32),ran),
pt_die,1);
}
repeat (5)
{
    var ran;
    ran=random(360);
    
    part_particles_create(ps,
    x+lengthdir_x(random(32),ran),
    y+lengthdir_y(random(32),ran),
    pt_explode,1);
}

if (hp <= 0) {
    switch(object_index) {
        case obj_zomb:
        //score += 100;
        repeat(1) { instance_create(x,y,obj_point);}
        break;
        
        case obj_chomp:
        //score += 200;
        repeat(2) { instance_create(x,y,obj_point);}
        break;
        
        case obj_blargh:
        //score += 500;
        repeat(5) { instance_create(x,y,obj_point);}
        break;
        
        case obj_shade:
        //score += 300;
        repeat(3) { instance_create(x,y,obj_point);}
        break;
        
        case obj_glob:
        repeat(3) { instance_create(x,y,obj_point);}
        break;
        
        case obj_root:
        repeat(3) { instance_create(x,y,obj_point);}
        break;
    }
}



ds_list_add(obj_pt_clean.pt, pt_explode);
ds_list_add(obj_pt_clean.pt, pt_die);
ds_list_add(obj_pt_clean.pt, pt_spawn);
ds_list_add(obj_pt_clean.pt, pt_fire);
