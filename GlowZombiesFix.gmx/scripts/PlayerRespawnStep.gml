PlayerViewAdjust();
if (instance_number(obj_player) == 0 && !respawn) {
    respawn = true;
    alarm[0] = respawnTimer;
}
else if (!respawn) {
    xx = obj_player.x;
    yy = obj_player.y;
    windex = obj_player.windex;
    weapon = obj_player.weapon;
}

if (/*dead &&*/ keyboard_check_pressed(ord('R'))) {
    game_restart();
}

if (keyboard_check_pressed(vk_space)
        && instance_number(obj_highscore_list) == 0
        && instance_number(obj_player) == 0) {
    instance_create(0, 0, obj_highscore_list);
}

if (keyboard_check_pressed(vk_enter) &&
        instance_number(obj_name_entry) == 0 &&
        !submitted && instance_number(obj_player) == 0) {
    with(obj_highscore_list) {
        instance_destroy();
    }
    with(obj_name_entry) {
        instance_destroy();
    }
    with(obj_submit_score_helper) {
        instance_destroy();
    }
    instance_create(0, 0, obj_name_entry);
}
