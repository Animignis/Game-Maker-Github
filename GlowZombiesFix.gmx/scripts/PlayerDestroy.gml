/*var txt = instance_create(x,y,obj_text_fade);
txt.text = choose("such explode", "much pain", "many ouch",
    "so dead", "such betrayal");
*/
repeat (5)
{
var ran;
ran=random(360);

part_particles_create(ps,

x+lengthdir_x(random(32),ran),
y+lengthdir_y(random(32),ran),

pt_explode,1);
}
repeat(50) {
var ran;
ran=random(360);
part_particles_create(ps,
x+lengthdir_x(random(32),ran),
y+lengthdir_y(random(32),ran),
pt_die,1);
}

ds_list_add(obj_pt_clean.pt, pt_explode);
ds_list_add(obj_pt_clean.pt, pt_die);
ds_list_add(obj_pt_clean.pt, ptSpark);
ds_list_add(obj_pt_clean.pt, pt_flash);
ds_list_add(obj_pt_clean.pt, pt_spawn);
ds_list_add(obj_pt_clean.pt, pt_laser);
ds_list_add(obj_pt_clean.ps_list, ps);

ds_list_destroy(wswap);
ds_list_destroy(ltn_chain);
