/******************
WEAPON STUFF
*******************/
/*
gunType:
0 = single gun
1 = double gun
*/
gunType = 0;
barrel_len = 24;

/*
weapon:
0 = single shot
1 = double shot
2 = triple shot
3 = flame thrower
4 = bomb
5 = laser
6 = lightning
7 = ice-beam
8 = doge
9 = burst
10 = missiles

homing shots???
charge shot

*/
weapon = 5;
weapon2 = 0;
barrier = false;
ltn = false;
ltn_enemy = -1;
ltn_range = 128;
ltn_angle = 60;
ltn_chain = ds_list_create();
ltn_cap = 2;

sword_spinrate = 20;

lsr = false;
lsr_enemy = -1;
lsr_w = 0;
lsr_dw = 0.4;
lsr_maxw = 5;

burst_size = 5;
burst_angle = 60;

weapon_damage[wpn_ltn] = 0.03;//0.0175;
weapon_damage[wpn_lsr] = 0.03;
weapon_damage[0] = 0.4;
weapon_damage[1] = 0.25;
weapon_damage[2] = 0.167;
weapon_damage[wpn_flame] = 0.004;
weapon_damage[wpn_doge] = 5;
weapon_damage[wpn_burst] = 1;
weapon_damage[wpn_missile] = 2;

wswap = ds_list_create();
ds_list_clear(wswap);
ds_list_add(wswap, 0);
ds_list_add(wswap, wpn_flame);
ds_list_add(wswap, wpn_lsr);
ds_list_add(wswap, wpn_ltn);
//ds_list_add(wswap, wpn_doge);
ds_list_add(wswap, wpn_burst);
windex = 0;

ammo_cap = 100;

weapon_ammo_up[wpn_burst] = -1;
weapon_ammo_up[wpn_ltn] = 1 / 6;
weapon_ammo_up[wpn_lsr] = 1/3;
weapon_ammo_up[0] = -1;
weapon_ammo_up[1] = -1;
weapon_ammo_up[2] = -1;
weapon_ammo_up[wpn_doge] = -1;
weapon_ammo_up[wpn_flame] = 0.25;
weapon_ammo_up[wpn_sword] = -1;
weapon_ammo_up[wpn_missile] = -1;

weapon_ammo_down[wpn_burst] = -1;
weapon_ammo_down[wpn_ltn] = 1/3;
weapon_ammo_down[wpn_lsr] = 1/3;
weapon_ammo_down[0] = -1;
weapon_ammo_down[1] = -1;
weapon_ammo_down[2] = -1;
weapon_ammo_down[wpn_doge] = -1;
weapon_ammo_down[wpn_flame] = 2;
weapon_ammo_down[wpn_sword] = -1;
weapon_ammo_down[wpn_missile] = -1;

weapon_ammo[wpn_burst] = -1;
weapon_ammo[wpn_ltn] = ammo_cap;
weapon_ammo[wpn_lsr] = ammo_cap;
weapon_ammo[0] = -1;
weapon_ammo[1] = -1;
weapon_ammo[2] = -1;
weapon_ammo[wpn_doge] = -1;
weapon_ammo[wpn_flame] = ammo_cap;
weapon_ammo[wpn_sword] = -1;
weapon_ammo[wpn_missile] = -1;

weapon_overheat[wpn_burst] = false;
weapon_overheat[wpn_ltn] = false;
weapon_overheat[wpn_lsr] = false;
weapon_overheat[0] = false;
weapon_overheat[1] = false;
weapon_overheat[2] = false;
weapon_overheat[wpn_doge] = false;
weapon_overheat[wpn_flame] = false;
weapon_overheat[wpn_sword] = false;
weapon_overheat[wpn_missile] = false;

weapon_ammo_lbl[wpn_burst] = "burst";
weapon_ammo_lbl[wpn_ltn] = "tesla";
weapon_ammo_lbl[wpn_lsr] = "laser";
weapon_ammo_lbl[0] = "single";
weapon_ammo_lbl[1] = "double";
weapon_ammo_lbl[2] = "triple";
weapon_ammo_lbl[wpn_flame] = "firewall";
weapon_ammo_lbl[wpn_doge] = "doge";
weapon_ammo_lbl[wpn_sword] = "sword";
weapon_ammo_lbl[wpn_missile] = "missile";

ammo_bar_w = 128;
ammo_bar_h = 8;
ammo_bar_wbor = 16;
ammo_bar_hbor = 16;