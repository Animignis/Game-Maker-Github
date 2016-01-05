if (jumping) {
    image_xscale += dscale;
    image_yscale = image_xscale;
    dscale -= g;
    
    image_alpha = 0.5;
    image_angle += 5;
    
    depth = -100;
    
    if (image_xscale < 1) {
        image_xscale = 1;
        image_yscale = 1;
        jumping = false;
        landed = true;
        image_alpha = 1;
        speed = 0;
        sprite_index = spr_main;
        GlobInit();
    }
}