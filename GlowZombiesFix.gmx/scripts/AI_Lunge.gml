if (!isAdjustDir) {
    direction = point_direction(x, y, obj_player.x, obj_player.y);
}
else {
    adjustDir += deltaDir;
    direction += deltaDir * adjustDirSign;
    show_debug_message(string(adjustDir));
    if (adjustDir >= adjustDirTempCap) {
        isAdjustDir = false;
        direction = (direction + 360) mod 360;
        targetLock = true;
    }
    else if (direction > deltaDir && direction < 360 - deltaDir) {
        if (abs(direction - targetAng) <= deltaDir) {
            isAdjustDir = false;
            direction = targetAng;
            targetLock = true;
        }
    }
    else if (direction <= deltaDir) {
        if (abs(direction - (targetAng - 360)) <= deltaDir) {
            isAdjustDir = false;
            targetLock = true;
        }
    }
    else if (direction >= 360 - deltaDir) {
        if (abs((direction - 360) - targetAng) <= deltaDir) {
            isAdjustDir = false;
            targetLock = true;
        }
    }
}