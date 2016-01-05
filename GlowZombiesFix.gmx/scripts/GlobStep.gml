if (instance_number(obj_player) > 0) {
if (ds_exists(obj_player.ltn_chain, ds_type_list)) {
        if (ds_list_find_index(obj_player.ltn_chain, id) != -1
                || id == obj_player.lsr_enemy) {
            if (jumping) {
                sprite_index = spr_spin_hurt;
            }
            else {
                sprite_index = spr_hurt;
            }
            image_blend = make_color_rgb(200, 200, 255);
        }
        else {
            image_blend = c_white;
            if (jumping) {
                sprite_index = spr_spin;
            }
            else {
                sprite_index = spr_main;
            }
        }
    }
}