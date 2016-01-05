var pwr = weapon_damage[argument0];
part_type_direction(pt_flash,image_angle-10,image_angle+10,0,0);
var weaponID = argument0;
switch(weaponID) {
    case 0:
    PlaySound(snd_shoot1);
    part_type_color3(pt_flash,c_white,c_aqua,c_aqua);
    var b = instance_create(
        x + lengthdir_x(barrel_len, image_angle), 
        y + lengthdir_y(barrel_len, image_angle), obj_bullet);
    b.image_angle = image_angle;
    b.direction = b.image_angle;
    part_particles_create(ps,b.x,b.y,pt_flash,20);
    canShoot = false;
    shotTimer = shotTimerCap;
    b.pwr = pwr;
    break;
    
    case wpn_burst:
    if (!charge) {
        PlaySound(snd_shoot1);
        part_type_color3(pt_flash,c_white,c_aqua,c_aqua);
        var b = instance_create(
            x + lengthdir_x(barrel_len, image_angle), 
            y + lengthdir_y(barrel_len, image_angle), obj_bullet);
        b.image_angle = image_angle;
        b.direction = b.image_angle;
        part_particles_create(ps,b.x,b.y,pt_flash,20);
        canShoot = false;
        shotTimer = shotTimerCap;
        b.pwr = weapon_damage[0];
        b.sprite_index = spr_bullet4;
        b.c = c_blue;
        part_type_color3(b.pt_die, c_aqua, c_blue, c_blue);
        part_type_color3(b.pt_explode, c_aqua, c_blue, c_blue);
    }
    break;
    
    case wpn_doge:
    if (canShoot2) {
        var b = instance_create(
            x + lengthdir_x(barrel_len, image_angle), 
            y + lengthdir_y(barrel_len, image_angle), obj_wow);
        b.image_angle = image_angle;
        if (image_angle >= 90 && image_angle < 270) {
            b.image_yscale = -1;
        }
        b.direction = image_angle;
        canShoot2 = false;
        shotTimer2 = shotTimerCap2;
        b.pwr = pwr;
    }
    break;
    
    case wpn_double:
    PlaySound(snd_shoot1);
    part_type_color3(pt_flash,c_white,c_aqua,c_aqua);
    var b = instance_create(
        x + lengthdir_x(58, image_angle + 30), 
        y + lengthdir_y(58, image_angle + 30), obj_bullet);
    b.image_angle = image_angle;
    b.direction = b.image_angle;
    b.pwr = pwr;
    part_particles_create(ps,b.x,b.y,pt_flash,20);
    b = instance_create(
        x + lengthdir_x(58, image_angle - 30), 
        y + lengthdir_y(58, image_angle - 30), obj_bullet);
    b.image_angle = image_angle;
    b.direction = b.image_angle;
    b.pwr = pwr;
    part_particles_create(ps,b.x,b.y,pt_flash,20);
    canShoot = false;
    shotTimer = shotTimerCap;
    break;
    
    case 2:
    PlaySound(snd_shoot1);
    part_type_color3(pt_flash,c_white,c_aqua,c_aqua);
    var b = instance_create(
        x + lengthdir_x(barrel_len, image_angle), 
        y + lengthdir_y(barrel_len, image_angle), obj_bullet);
    b.image_angle = image_angle;
    b.direction = b.image_angle;
    b.pwr = pwr;
    b = instance_create(
        x + lengthdir_x(barrel_len, image_angle), 
        y + lengthdir_y(barrel_len, image_angle), obj_bullet);
    b.image_angle = image_angle + 20;
    b.direction = b.image_angle;
    b.pwr = pwr;
    b = instance_create(
        x + lengthdir_x(barrel_len, image_angle), 
        y + lengthdir_y(barrel_len, image_angle), obj_bullet);
    b.image_angle = image_angle - 20;
    b.direction = b.image_angle;
    b.pwr = pwr;
    canShoot = false;
    shotTimer = shotTimerCap;
    break;
    
    case wpn_flame:
    PlaySound(snd_shoot1);
    if (weapon_ammo[wpn_flame] > 0 && !weapon_overheat[wpn_flame]) {
        weapon_ammo[wpn_flame] -= weapon_ammo_down[weaponID];
        if (weapon_ammo[weaponID] <= 0) {
            weapon_ammo[weaponID] = 0;
            weapon_overheat[weaponID] = true;
            windex = 0;
        }
        part_type_color3(pt_flash,c_yellow,c_orange,c_red);
        gunType = 0;
        var f = instance_create(
            x + lengthdir_x(barrel_len, image_angle), 
            y + lengthdir_y(barrel_len, image_angle), obj_flame);
        //f.image_angle = image_angle;
        f.direction = image_angle;
        part_particles_create(ps,f.x,f.y,pt_flash,20);
        canShoot = false;
        f.pwr = pwr;
        shotTimer = flameTimerCap;
    }
    break;
    
    case wpn_lsr:
    break;
    
    case wpn_ltn:
    
    if (weapon_ammo[weaponID] > 0 && !weapon_overheat[weaponID]) {
        weapon_ammo[weaponID] -= weapon_ammo_down[weaponID];
        if (weapon_ammo[weaponID] <= 0) {
            weapon_ammo[weaponID] = 0;
            weapon_overheat[weaponID] = true;
            windex = 0;
        }
        var x1 = x + lengthdir_x(barrel_len, image_angle);
        var y1 = y + lengthdir_y(barrel_len, image_angle);
        
        //if (ltn_enemy = -1) {
        var obj = instance_nearest(x1, y1, obj_enemy_pa);
        var objD = point_distance(x1, y1, obj.x, obj.y);
        var angleCheck = point_direction(x1, y1, obj.x, obj.y);
        var imgAng = image_angle;
        if (angleCheck >= 360 - ltn_angle && imgAng <= ltn_angle) {
            angleCheck -= 360;
        }
        else if (imgAng >= 360 - ltn_angle && angleCheck <= ltn_angle) {
            angleCheck += 360;
        }
        
        if (objD <= ltn_range &&
                angleCheck <= imgAng + ltn_angle &&
                angleCheck >= imgAng - ltn_angle) {
            ltn_enemy = obj;
        }
        else{
            obj = -1;
            var leastRange = ltn_range * 2;
            var i;
            for (i = 0; i < instance_number(obj_enemy_pa); i++) {
                var obj1 = instance_find(obj_enemy_pa, i);
                var d = point_distance(x1, y1, obj1.x, obj1.y);
                angleCheck = point_direction(x1, y1, obj1.x, obj1.y);
                if (angleCheck >= 0 && angleCheck <= ltn_angle && 
                        imgAng <= 360 && imgAng >= 360 - ltn_angle) {
                    imgAng -= 180;
                    angleCheck += 180;
                }
                else if (angleCheck <= 360 && angleCheck >= 360 - ltn_angle &&
                        imgAng >= 0 && imgAng <= ltn_angle) {
                    imgAng += 180;
                    angleCheck -= 180;
                }
                if (d <= ltn_range &&
                        angleCheck <= imgAng + ltn_angle &&
                        angleCheck >= imgAng - ltn_angle) {
                    obj = obj1;
                }
            }
            ltn_enemy = obj;
        }
    }else {
        ds_list_clear(ltn_chain);
    }
    //}
    break;
}