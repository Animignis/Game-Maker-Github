PlayerWeaponSwap();
PlayerFireCheck();

if (poisoned) {
    health -= poisonRate;
}

if (!stunned) {
    PlayerMove();
}
else {
    image_blend = c_yellow;
}

PlayerTimers();

if (hurt || stunned) {
    PlayerIsHurt();
}

if (image_alpha < 1 && !fullSpawn) {
    image_alpha += da;
}
else if (!fullSpawn) {
    image_alpha = 1;
    fullSpawn = true;
    //sprite_index = spr_main;
    part_particles_create(ps,x,y,pt_spawn,1);
}

if (health <= 0) {
    lives--;
    health = obj_playerRespawn.maxHealth;
    instance_destroy();
}

if (recover) {
    health += recoverRate;
}

if (health > maxHealth) {
    recover = false;
    health = maxHealth;
}
