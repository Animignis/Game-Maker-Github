if (shotTimer > 0) {
    shotTimer--;
}
else if (shotTimer == 0) {
    shotTimer = -1;
    canShoot = true;
}

if (shotTimer2 > 0) {
    shotTimer2--;
}
else if (shotTimer2 == 0) {
    shotTimer2 = -1;
    canShoot2 = true;
}

if (swordTimer > 0) {
    swordTimer--;
}
else if (swordTimer == 0) {
    swordTimer = -1;
    weapon = 0;
    windex = 0;
    with(obj_sword) {
        instance_destroy();
    }
}

if (hurtTimer > 0) {
    hurtTimer--;
}
else if (hurtTimer == 0) {
    hurtTimer = -1;
    hurt = false;
    image_alpha = 1;
    sprite_index = spr_main;
    sprSwitchTimer = -1;
}

if (blindTimer > 0) {
    blindTimer--;
}
else if (blindTimer == 0) {
    blindTimer = -1;
    blind = false;
    blindAlphaFade = false;
    blindAlpha = 0;
}

if (stunTimer > 0) {
    stunTimer--;
}
else if (stunTimer == 0) {
    stunTimer = -1;
    stunned = false;
    image_blend = c_white;
    sprite_index = spr_main;
    sprSwitchTimer = -1;
    hurt = true;
    hurtTimer = hurtTimerCap;
}

if (recoverTimer > 0) {
    recoverTimer--;
}
else if (recoverTimer == 0) {
    recoverTimer = -1;
    recover = true;
}

if (slowTimer > 0) {
    slowTimer--;
}
else if (slowTimer == 0) {
    slowTimer = -1;
    slowed = false;
}

if (poisonTimer > 0) {
    poisonTimer--;
}
else if (poisonTimer == 0) {
    poisonTimer = -1;
    poisoned = false;
}
