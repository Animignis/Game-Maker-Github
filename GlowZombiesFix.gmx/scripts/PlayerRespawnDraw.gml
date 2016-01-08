draw_set_font(fnt_score);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(view_xview,view_yview,"score: " + string(score));
draw_text(view_xview,view_yview + string_height("A"),"lives: " + string(lives));
var ang = point_direction(xx,yy,mouse_x,mouse_y);
draw_sprite_ext(spr_cursor2, 0, mouse_x, mouse_y, 1, 1, ang, c_white, 0.8);
if (instance_number(obj_highscore_list) == 0 
        && instance_number(obj_name_entry) == 0) {
    draw_set_alpha(0.75);
    var mincol = make_color_rgb(0, 0, 100);
    var maxcol = c_aqua;
    if (obj_player.poisoned) {
        mincol = c_purple;
        maxcol = c_fuchsia;
    }
    draw_healthbar(
        view_xview + 4, view_yview + view_hview * 0.25,
        view_xview + 12, view_yview+ view_hview * 0.75,
        (health / maxHealth) * 100, c_black, 
        mincol, maxcol, 3, false, true);
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_rectangle(
        view_xview + 4, view_yview + view_hview * 0.25,
        view_xview + 12, view_yview+ view_hview * 0.75,
        true);
    if (dead) {
        draw_set_valign(fa_middle);
        draw_set_halign(fa_center);
        draw_set_color(c_white);
        draw_set_font(fnt_over);
        draw_text(view_xview + view_wview * 0.5, view_yview + view_hview * 0.3,
            "GAME OVER");
        draw_set_font(fnt_instruct);
        draw_text(view_xview + view_wview * 0.5, view_yview + view_hview * 0.5,
            "press R to restart");
        draw_text(view_xview + view_wview * 0.5, view_yview + view_hview * 0.5,
            "##press ENTER to submit score online");
        draw_text(view_xview + view_wview * 0.5, view_yview + view_hview * 0.5,
            "####press SPACE to view global highscores");
    }
}
