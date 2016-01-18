if (attackStart) {
    EnemySpawnHitboxes();
    targetDir = direction;
    attackStart = false;
}
if (image_index >= (image_number - 1 - image_speed)) {
    state = CHASE;
    attackStart = true;
}
