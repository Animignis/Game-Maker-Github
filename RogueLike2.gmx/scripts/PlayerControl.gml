PlayerTimers();

health = hp;

//aim
image_angle = point_direction(x, y, mouse_x, mouse_y);

//move
PlayerMove();

//control view
PlayerViewAdjust();

//attack controls
if (mouse_check_button(mb_left)) {
    if (canAttack[weapon]) {
        PlayerAttack();
        canAttack[weapon] = false;
        attackTimers[weapon] = attackTimerCaps[weapon];
    }
    var xx = x;
    var yy = y;
    with(obj_splatters) {
        //AddSplat(xx, yy, floor(random_range(0, 254)));
    }
}

if (canSpawn >= 0) {
    canSpawn--;
}
if (mouse_check_button(mb_right) && canSpawn == -1) {
    instance_create(mouse_x, mouse_y, obj_shock);
    canSpawn += 5;
}


