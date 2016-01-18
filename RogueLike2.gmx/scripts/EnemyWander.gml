speed = maxSpeed;

var d1 = direction + sightAngle;
var d2 = direction - sightAngle;
if (canSeePlayer && point_in_triangle(obj_player.x, obj_player.y, x, y,
            x+lengthdir_x(sightRange, d1),y+lengthdir_y(sightRange, d1),
            x+lengthdir_x(sightRange, d2),y+lengthdir_y(sightRange, d2))) {
    state = CHASE;
    targetDir = point_direction(x, y, obj_player.x, obj_player.y);
    return 0;
}

// turn randomly
var r = random(1);
if (targetDir == direction && r <= wanderChance) {
    targetDir = floor(direction + choose(random_range(-90, -15), random_range(15, 90)));
}
