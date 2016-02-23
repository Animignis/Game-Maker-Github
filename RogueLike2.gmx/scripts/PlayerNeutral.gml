//move
PlayerMove();

//attack controls
if (canAttack) {
    weapon = -1;
    if (mouse_check_button(mb_left)) {
        weapon = 0; if (keyboard_check(vk_shift)) { weapon = 2; }
    }
    else if (mouse_check_button(mb_right)) {
        weapon = 1; if (keyboard_check(vk_shift)) { weapon = 3; }
    }
    if (weapon >= 0 && attackTimers[weapon] == -1) {
        attackTimers[weapon] = attackTimerCaps[weapon];
        PlayerAttack(weapon);
    }
}

// DEBUG FUNCTIONS
if (canSpawn >= 0) {
    canSpawn--;
}
if (keyboard_check(vk_add) && canSpawn == -1) {
    instance_create(mouse_x, mouse_y, obj_shock);
    canSpawn += 5;
}
