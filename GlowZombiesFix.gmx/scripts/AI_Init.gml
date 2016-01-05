state = 0;
/*
state:
0 = wandering
1 = following OR targeting/lunging
2 = lunging
*/

isAdjustDir = false;
adjustDirChance = 0.015;
adjustDirMax = 90;
adjustDirMin = 20;
adjustDirTempCap = 0;
adjustDir = 0;
adjustDirSign = 1;
deltaDir = 0;
deltaDirMin = 3;
deltaDirMax = 8;
followRange = 300;
sightAngle = 60;
targetLock = 0;
isHit = false;
isHitTimerCap = room_speed;
isHitTimer = -1;

if (object_index == obj_chomp) {
    //target coordinates
    lungeSpeed = maxspeed * 4;
    /*
    targetLock:
    0 = no target
    1 = aiming
    2 = lunging
    3 = lunge ended
    */
    image_speed = 0.1;
    image_index = 0;
    aimTimerCap = room_speed;
    aimTimer = -1;
    lungeTimerCap = room_speed * 0.75;
    lungeTimer = -1;
    stallTimerCap = room_speed * 0.75;
    stallTimer = -1;
    followRange = 300;
}
else if (object_index == obj_blargh) {
    maxspeed *= 0.5;
    followRange = 50;
    deltaDirMin = 0.5;
    deltaDirMax = 1;
    adjustDirChance = 0.01;
    image_speed = 5/60;
}
else if (object_index == obj_shade) {
    maxspeed = 4.5;
    followRange = 300;
    deltaDirMin = 1.5;
    deltaDirMax = 3;
    adjustDirChance = 0.03;
    adjustDirMin = 45;
    adjustDirMax = 90;
    image_speed = 5/60;
    image_index = 0;
}
else if (object_index == obj_root) {
    maxspeed = 0;
    followRange = 400;
    deltaDirMin = 4;
    deltaDirMax = 7;
    adjustDirMin = 45;
    adjustDirMax = 90;
    image_speed = 0;
    image_index = 0;
    canFire = true;
    canFireTimerCap = 1 * room_speed;
    canFireTimer = -1;
}

speed = maxspeed;
direction = random(360);