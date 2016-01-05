PlaySound(snd_bullet_hit);

ds_list_add(obj_pt_clean.pt, pt_explode);
if (part_type_exists(pt_fire)) {
    ds_list_add(obj_pt_clean.pt, pt_fire);
}
if (part_type_exists(pt_die)) {
    ds_list_add(obj_pt_clean.pt, pt_die);
}