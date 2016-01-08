var d = point_distance(x, y, obj_player.x, obj_player.y);
var angCheck = point_direction(x, y, obj_player.x, obj_player.y);
var ang = abs(direction) mod 360;
//show_debug_message(string(angCheck));
if (angCheck >= 360 - sightAngle && ang <= sightAngle) {
    angCheck -= 360;
    //adjustDirSign = -1;
}
else if (ang >= 360 - sightAngle && angCheck <= sightAngle) {
    angCheck += 360;
    //adjustDirSign = 1;
}

if (ds_list_find_index(obj_player.ltn_chain, id) != -1
        || id == obj_player.lsr_enemy) {
    isHitTimer = isHitTimerCap;
    isHit = true;
    sprite_index = spr_hurt;
    image_blend = make_color_rgb(200, 200, 255);
}
else {
    image_blend = c_white;
    sprite_index = spr_main;
}
AI_ShadeIndexImage();

if (targetLock == 1) {
    isHit = false;
    isHitTimer = -1;
}

if (state != 2) {
if ((d < followRange && angCheck <= ang + sightAngle &&
        angCheck >= ang - sightAngle &&
        !collision_line(x, y, obj_player.x, obj_player.y,
            obj_wall, 0, 1)) || (targetLock == 1 && object_index == obj_chomp)
            || isHit) {
    state = 1;
    //direction = point_direction(x,y,obj_player.x,obj_player.y);
    if (!isAdjustDir && !targetLock) {
        targetLock = false;
        isAdjustDir = true;
        deltaDir = deltaDirMin;
        adjustDir = 0;
        /*var angCheck = point_direction(x, y, obj_player.x, obj_player.y);
        var ang = abs(direction) mod 360;
        show_debug_message(string(angCheck));
        if (angCheck >= 360 - sightAngle && ang <= sightAngle) {
            angCheck -= 360;
            adjustDirSign = -1;
        }
        else if (ang >= 360 - sightAngle && angCheck <= sightAngle) {
            angCheck += 360;
            adjustDirSign = 1;
        }else {*/
            adjustDirSign = sign(angCheck - ang);
        //}
        adjustDirTempCap = abs(angCheck - ang);
        /*show_debug_message(string(ang));
        show_debug_message(string(angCheck));
        show_debug_message(string(adjustDirTempCap));*/
    }
    if (object_index == obj_chomp && targetLock != 2) {
        image_speed = 0.2;
        speed = 0;
    }
}
//}
else if (state != 2) {
    state = 0;
    targetLock = 0;
    speed = maxspeed;
}
}
