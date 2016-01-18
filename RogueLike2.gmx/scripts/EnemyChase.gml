var px = obj_player.x;
var py = obj_player.y;
var dist = point_distance(x, y, px, py);

if (dist <= attackRange) {
    speed = 0;
    state = ATTACK;
}
else if (dist <= chaseRange && dist) {
    speed = maxSpeed;
}
else {
    speed = 0;
}

targetDir = point_direction(x, y, px, py);

if (!canSeePlayer) {
    lostSightCount++;
    if (lostSightCount >= lostSightCap) {
        lostSightCount = 0;
        state = WANDER;
    }
}
else {
    lostSightCount = 0;
}
