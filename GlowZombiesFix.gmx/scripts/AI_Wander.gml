if (isAdjustDir) {
    adjustDir += deltaDir;
    direction += deltaDir * adjustDirSign;
    if (adjustDir >= adjustDirTempCap) {
        isAdjustDir = false;
        direction = (direction + 360) mod 360;
    }
}
else {
    var rmax = 100;
    var r = random(rmax);
    if (r <= adjustDirChance * rmax) {
        isAdjustDir = true;
        adjustDir = 0;
        deltaDir = random_range(deltaDirMin, deltaDirMax);
        if (object_index == obj_shade) {
            adjustDirSign *= -1;
        } else {
            adjustDirSign = choose(-1, 1);
        }
        adjustDirTempCap = random_range(adjustDirMin, adjustDirMax);
    }
}
AI_ShadeIndexImage();
