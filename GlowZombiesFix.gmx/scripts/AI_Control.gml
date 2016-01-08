if (instance_number(obj_player) > 0) {
    AI_StateCheck();
    switch(state) {
        case 0:
        AI_Wander();
        break;
        
        case 1:
        //direction = point_direction(x, y, obj_player.x, obj_player.y);
        AI_Follow();
        break;
    }
}
else {
    AI_Wander();
}

if (object_index == obj_root) {
    if (canFireTimer > 0) {
        canFireTimer--;
    }
    else if (canFireTimer == 0) {
        canFire = true;
        canFireTimer = -1;
    }
}
