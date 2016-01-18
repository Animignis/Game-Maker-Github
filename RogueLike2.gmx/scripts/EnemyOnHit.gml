/// EnemyOnHit(damage);
Shake(4, 2);
if (!invincible) {
    hp -= argument0;
    speed = 0;
    hurtTimer = hurtTimerCap;
    prevDifState = state;
    if (prevDifState == WANDER) {
        prevDifState = CHASE;
    }
    state = HURT;
}
