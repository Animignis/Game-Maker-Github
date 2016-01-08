var canCollide = true;

if(other.object_index == obj_glob) {
    if (other.jumping) {
        canCollide = false;
    }
}

if(weapon == wpn_sword) {
    canCollide = false;
}

if(canCollide) {
    with(other) { 
        if (fullSpawn && !obj_player.hurt) {
            instance_destroy();
        }
    }
    if (other.fullSpawn && fullSpawn && !hurt) {
        recoverTimer = recoverTimerCap;
        health -= other.damage;
        hurt = true;
        recover = false;
        hurtTimer = hurtTimerCap;
        if (other.object_index == obj_shade) {
            blind = true;
            blindTimer = blindTimerCap * other.hp / other.maxhp;
            blindAlphaFade = false;
            blindAlpha = 0;
        }
    }
}
