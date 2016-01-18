if (attackStart >= 0) {
    attackStart--;
    speed = 0;
    direction = point_direction(x, y, obj_player.x, obj_player.y);
    targetDir = direction;
    if (attackStart < 0) {
        var hb1 = instance_create(
            x, y, obj_hitbox);
        hb1.delay = 1;
        hb1.size = CELL_SIZE / 2;
        hb1.dmg = dmg;
        hb1.life = attackTimerCap;
        hb1.vehicle = id;
    }
}
else {
    speed = attackSpeed;
    invincible = true;
    attackTimer--;
    if (attackTimer < 0) {
        invincible = false;
        state = WANDER;
        attackStart = attackStartCap;
        attackTimer = attackTimerCap;
    }
}
