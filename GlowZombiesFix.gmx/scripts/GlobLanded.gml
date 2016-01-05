if (landed) {
    image_xscale = 1 + diff_scale*sin(sin_count);
    image_yscale = 1 - diff_scale*sin(sin_count);
    
    sin_count += sin_rate;
    diff_scale -= diff_scale_change;
    depth = 0;
    
    if (diff_scale <= 0) {
        diff_scale = diff_scale_max;
        sin_count = 0;
        landed = false;
        image_xscale = 1;
        image_yscale = 1;
        jumping = true;
        sprite_index = spr_spin;
        jumpDist = random_range(minDist, maxDist);
        speed = jumpDist / 102;
        var xx, yy, r, ang;
        r = 32;
        ang = 0;
        do {
            ang = random(360);
            xx = x + lengthdir_x(jumpDist, ang);
            yy = y + lengthdir_y(jumpDist, ang);
            jumpDist = random_range(minDist, maxDist);
        } until(!collision_circle(xx, yy, r, obj_wall, false, false));
        direction = ang;
    }
}