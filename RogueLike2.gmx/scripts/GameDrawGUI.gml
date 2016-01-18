draw_set_color(c_red);
draw_set_font(fnt_main);
draw_text(0, 0, "FPS: " +string(fps_real));
draw_text(0, 32, "enemies: " + string(numEnemies));
draw_text(0, 64, "score: " + string(score));
draw_text(256, 0, "tiles: " + string(tile_get_count()))
draw_set_color(c_white);

if (global.win) {
    draw_set_font(fnt_large);
    draw_set_color(c_lime);
    draw_set_alpha(0.8);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(view_wport / 2, view_hport / 2, "WINNER");
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

draw_set_alpha(1);
draw_set_color(c_white);
