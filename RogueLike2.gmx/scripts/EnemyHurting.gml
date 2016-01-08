if (hurtTimer > 0) {
    hurtTimer -= 1;
}
else {
    state = CHASE;
    sprite_index = spr;
    hurtTimer = -1;
}
