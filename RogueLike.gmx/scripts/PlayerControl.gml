PlayerTimers();

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
}
