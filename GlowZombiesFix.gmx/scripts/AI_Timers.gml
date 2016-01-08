if (isHitTimer > 0) {
    isHitTimer--;
}
else if (isHitTimer == 0) {
    isHitTimer = -1;
    isHit = false;
}

//show_debug_message(string(speed));
if (aimTimer > 0) {
    aimTimer--;
}
else if (aimTimer == 0) {
    aimTimer = -1;
    targetLock = 2;
    //lunging now
    speed = lungeSpeed;
    image_speed = 0.4;
    lungeTimer = lungeTimerCap;
    state = 2;
}

if (lungeTimer > 0) {
    lungeTimer--;
}
else if (lungeTimer == 0) {
    lungeTimer = -1;
    targetLock = 3;
    //stalling now
    speed = 0;
    stallTimer = stallTimerCap;
    image_speed = 0.2;
}

if (stallTimer > 0) {
    stallTimer--;
}
else if (stallTimer == 0) {
    stallTimer = -1;
    targetLock = 0;
    image_speed = 0.1;
    //done
    state = 0;
    speed = maxspeed;
    state = 0;
}
