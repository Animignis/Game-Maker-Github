if (blind) {
    PlayerIsBlind();
}

if (weapon_overheat[weapon]) {
    image_blend = make_color_rgb(155, 155, 155);
}
else if (!charge) {
    image_blend = c_white;
}
draw_self();

PlayerDrawWeaponName(ds_list_find_value(wswap, windex));

if (ltn && weapon_ammo[wpn_ltn] > 0&& !weapon_overheat[wpn_ltn]) {
    PlayerLtnDraw();
}
if (lsr && weapon_ammo[wpn_lsr] > 0 && !weapon_overheat[wpn_lsr]) {
    weapon_ammo[wpn_lsr] -= weapon_ammo_down[wpn_lsr];
    if (weapon_ammo[wpn_lsr] <= 0) {
        weapon_ammo[wpn_lsr] = 0;
        weapon_overheat[wpn_lsr] = true;
        windex = 0;
    }
    PlayerFireDrawLaser();
}
PlayerCheckDrawAmmo();
//draw_sprite(spr_hp, 0, x, y - 128);

if (shotTimer2 > 0) {
    draw_set_alpha(0.5);
    draw_healthbar(
        x - ammo_bar_w * 0.5,
        y - sprite_height * 0.6 - ammo_bar_h,
        x + ammo_bar_w * 0.5,
        y - sprite_height * 0.6,
        shotTimer2 / shotTimerCap2 * 100,
        c_white, c_green, c_lime, 0, false, true);
    draw_set_color(c_white);
    draw_rectangle(
        x - ammo_bar_w * 0.5,
        y - sprite_height * 0.6 - ammo_bar_h,
        x + ammo_bar_w * 0.5,
        y - sprite_height * 0.6, true);
    draw_set_alpha(1);
}
