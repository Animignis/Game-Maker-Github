/*if (id == obj_player.lsr_enemy) {
    image_blend = make_color_rgb(128, 128, 255);
    image_alpha = 1;
    //draw_set_blend_mode(bm_add);
}
else {
    image_blend = c_white;
    image_alpha = 1;
    draw_set_blend_mode(bm_normal);
}*/

if (object_index == obj_root) {
    draw_sprite(spr_root, 1, x, y);
}

draw_self();
draw_set_blend_mode(bm_normal);
