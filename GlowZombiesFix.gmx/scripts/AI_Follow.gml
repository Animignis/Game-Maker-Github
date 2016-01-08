var targetAng = point_direction(x, y, obj_player.x, obj_player.y);

if (!isAdjustDir) {
    if (targetLock == 1) {
        direction = point_direction(x, y, obj_player.x, obj_player.y);
        
        if (object_index == obj_root) {
            if (canFire) {
                instance_create(x, y, obj_spore);
                canFire = false;
                canFireTimer = canFireTimerCap;
            }
        }
    }
}
else {
    adjustDir += deltaDir;
    direction += deltaDir * adjustDirSign;
    
    if (adjustDir >= adjustDirTempCap) {
        isAdjustDir = false;
        direction = (direction + 360) mod 360;
        targetLock = 1;
    }
    else if (direction > deltaDir && direction < 360 - deltaDir) {
        if (abs(direction - targetAng) <= deltaDir) {
            isAdjustDir = false;
            direction = targetAng;
            targetLock = 1;
        }
    }
    else if (direction <= deltaDir) {
        if (abs(direction - (targetAng - 360)) <= deltaDir) {
            isAdjustDir = false;
            targetLock = 1;
        }
    }
    else if (direction >= 360 - deltaDir) {
        if (abs((direction - 360) - targetAng) <= deltaDir) {
            isAdjustDir = false;
            targetLock = 1;
        }
    }
    
    if (targetLock == 1 && object_index == obj_chomp && !isAdjustDir) {
        aimTimer = aimTimerCap;
        image_speed = 0.2;
        speed = 0;
    }
}
