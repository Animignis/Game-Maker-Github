var canBeShot = true;
if (object_index == obj_glob) {
    if (jumping) {
        canBeShot = false;
    }
}

if (canBeShot) {
    switch(other.object_index) {
        case obj_bullet:
        if (object_index == obj_chomp) {
            if (lungeTimer > 0) {
                hp -= other.pwr * 1.5;
            }
            else {
                hp -= other.pwr;
            }
        }
        else {
            hp -= other.pwr;
        }
        
        with(other) {
            instance_destroy();
        }
        isHitTimer = isHitTimerCap;
        isHit = true;
        sprite_index = spr_hurt;
        image_blend = make_color_rgb(155, 155, 255);
        break;
    
        case obj_flame:
        fire = true;
        fireTimer = fireTimerCap;
        isHitTimer = isHitTimerCap;
        isHit = true;
        sprite_index = spr_hurt;
        image_blend = make_color_rgb(255, 155, 155);
        break;
        
        case obj_wow:
        hp = 0;
        var txt = instance_create(x,y,obj_text_fade);
        txt.text = choose("many points", "so amaze", "much banana",
            "such explode");
        break;
    }
}
