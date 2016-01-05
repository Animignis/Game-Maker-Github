spr_spin = spr_glob_spin;
spr_spin_hurt = spr_glob_spinWhite;
image_speed = 0.2;

image_angle = random(360);

diff_scale_max = 0.3;
diff_scale = diff_scale_max;
diff_scale_change = 0.005;
sin_count = 0;
sin_rate = pi / 16;
maxDist = 64;
minDist = 32;
jumpDist = random_range(minDist, maxDist);
myspeed = jumpDist / 102;

landed = true;

dscale = 0.05;
g = 0.001;

jumping = false;
var rmax = 32;
var ang = random(360);
repeat(4){
    var xx, yy;
    r = random_range(rmax * 0.25, rmax);
    xx = x + lengthdir_x(r, ang);
    yy = y + lengthdir_y(r, ang);
    var splat = instance_create(xx,yy,obj_splat);
    splat.image_angle = random(360);
    splat.c = c_lime;
    splat.image_blend = c_lime;
    splat.damage = 0;
    part_type_shape(splat.pt_splat,pt_shape_ring);
    part_type_alpha3(splat.pt_splat,0.5,0.25,0);
    part_type_scale(splat.pt_splat,0.2,0.2);
    ang += 90;
}