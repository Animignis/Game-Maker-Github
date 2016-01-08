if (hp <= 0) {
    instance_destroy();
}

if (image_alpha < 1) {
    image_alpha += da;
}
else {
    image_alpha = 1;
    fullSpawn = true;
}

if (fire) {
    hp -= obj_player.weapon_damage[wpn_flame];
    repeat (5)
    {
    part_particles_create(ps,
        x-24+random(48),
        y-24+random(48),
        pt_fire,1);
    }
}

if (fireTimer > 0) {
    fireTimer--;
}
else if (fireTimer == 0) {
    fireTimer = -1;
    fire = false;
}
