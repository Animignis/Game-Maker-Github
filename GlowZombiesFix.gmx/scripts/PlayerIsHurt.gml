sprSwitchTimer++;
if (sprSwitchTimer == 1) {
    if (sprite_index == spr_main) {
        sprite_index = spr_hurt;
        image_index = weapon;
    }else if (sprite_index == spr_hurt){
        sprite_index = spr_main;
        image_index = weapon;
    }
}

if (sprSwitchTimer >= sprSwitchTimerCap) {
    sprSwitchTimer = 0;
}