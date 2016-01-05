var i = 0;
var count = 0;
draw_set_alpha(0.75);
ammo_cap = 100;
for (i = 0; i < ds_list_size(wswap); i++) {
    var index = ds_list_find_value(wswap, i);
    if ((!(mouse_check_button(mb_left))
            || weapon != index) && weapon_ammo[index] != -1) {
        weapon_ammo[index] += weapon_ammo_up[index];
        if(weapon_ammo[index] > ammo_cap) {
            weapon_ammo[index] = ammo_cap;
            weapon_overheat[index] = false;
        }
    }
    else if (weapon_overheat[index]) {
        weapon_ammo[index] += weapon_ammo_up[index];
    }
    
    if (weapon_ammo[index] < ammo_cap && weapon_ammo[index] != -1) {
        if (weapon_overheat[index]) {
            draw_set_alpha(0.5);
        }
        var ammo = weapon_ammo[index];
        var ammo_cap = ammo_cap;
        var xoff_left = ammo_bar_wbor*(count+1) + ammo_bar_w*(count+1);
        var xoff_right = ammo_bar_wbor*(count+1) + ammo_bar_w*count;
        var cmin = c_aqua;
        var cmax = c_red;
        if (weapon_overheat[index]) {
            draw_set_alpha(0.9);
            cmin = c_red;
        }
        draw_healthbar(
            view_xview + view_wview - xoff_left, 
            view_yview + view_hview - ammo_bar_h - ammo_bar_hbor,
            view_xview + view_wview - xoff_right, 
            view_yview + view_hview - ammo_bar_hbor,
            (1 - ammo / ammo_cap)*100,
            c_black, cmin, cmax, 1, false, false);
        draw_rectangle_color(
            view_xview + view_wview - xoff_left, 
            view_yview + view_hview - ammo_bar_h - ammo_bar_hbor,
            view_xview + view_wview - xoff_right, 
            view_yview + view_hview - ammo_bar_hbor,
            c_white, c_white, c_white, c_white, true);
        draw_set_font(fnt_ammo);
        draw_set_color(c_white);
        if (weapon_overheat[index]) {
            draw_set_alpha(0.75);
            draw_set_color(c_red);
        }
        draw_set_halign(fa_right);
        draw_set_valign(fa_bottom);
        var lbl = weapon_ammo_lbl[index];
        draw_text(view_xview + view_wview - xoff_right,
            view_yview + view_hview - ammo_bar_h - ammo_bar_hbor, lbl);
        count++;
    }
}
draw_set_alpha(1);