image_index = weapon;

if (weapon != wpn_sword) {
    image_angle = point_direction(x, y, mouse_x, mouse_y);
}
else {
    image_angle += sword_spinrate;
}
if (canShoot) {
    if (mouse_check_button_pressed(mb_left)){
        if (weapon = wpn_burst) {
            chargeTimer = chargeTimerCap;
            charge = true;
            
        }
    }
    else if (mouse_check_button_released(mb_left)){
        if (weapon == wpn_ltn) {
            ltn = false;
            ds_list_clear(ltn_chain);
        }
        else if (weapon == wpn_lsr) {
            lsr = false;
        }
        lsr_enemy = -1;
        ltn_enemy = -1;
        charge = false;
        chargeTimer = -1;
        image_blend = c_white;
    }
    if (mouse_check_button(mb_left)) {
        if (weapon = wpn_burst) {
            if (chargeTimer > 0) {
                chargeTimer--;
                charge = true;
                image_blend = make_color_hsv(200,
                    255 - chargeTimer / chargeTimerCap * 255, 255);
            }
            else if (chargeTimer == 0) {
                charge = false;
                chargeTimer = -1;
                image_blend = c_white;
                PlaySound(snd_shoot1);
                var i;
                for (i = 0; i < burst_size; i++) {
                    part_type_color3(pt_flash,c_white,c_aqua,c_aqua);
                    var b = instance_create(
                        x + lengthdir_x(barrel_len, image_angle), 
                        y + lengthdir_y(barrel_len, image_angle), obj_bullet);
                    b.image_angle = image_angle + burst_angle * 0.5 - i * burst_angle /  (burst_size - 1);
                    b.direction = b.image_angle;
                    part_particles_create(ps,b.x,b.y,pt_flash,20);
                    canShoot = false;
                    shotTimer = shotTimerCap;
                    b.pwr = weapon_damage[wpn_burst];
                    b.sprite_index = spr_bullet_burst;
                    b.c = c_purple;
                    part_type_color3(b.pt_die, c_white, c_fuchsia, c_purple);
                    part_type_color3(b.pt_explode, c_white, c_fuchsia, c_purple);
                }
            }
        }
    
        if (weapon2 == wpn_ltn) {
            ltn = false;
        }
        else if (weapon2 == wpn_lsr) {
            lsr = false;
        }
        
        if (weapon == wpn_ltn) {
            ltn = true;
        }
        else if (weapon == wpn_lsr) {
            lsr = true;
        }
        
        PlayerFire(weapon);
    }
}

if (weapon != 6) {
    ltn = false;
    ds_list_clear(ltn_chain);
    ltn_enemy = -1;
}
if (weapon != 5) {
    lsr = false;
    lsr_enemy = -1;
}