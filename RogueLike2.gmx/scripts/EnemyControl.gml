if (!spawned) {
    EnemyFullSpawn();
    spawned = true;
}

// needs to be reset to false every frame
// used by SetPrevNewEdges for setting canSeePlayer
hasSetCanSeePlayer = false;

// STATE MACHINE
switch(state) {
    case WANDER:
        EnemyWander();
        break;
    case CHASE:
        EnemyChase();
        break;
        
    case HURT:
        EnemyHurt();
        break;
    
    case ATTACK:
        switch(object_index) {
            default:
                EnemyAttack();
                break;
            case obj_chomp:
                ChompAttack();
                break;
        }
        break;
}
if (prevState != state) {
    image_index = 0;
    image_speed = imgSpeeds[state];
    sprite_index = sprites[state];
}
prevState = state;

// CHECK HEALTH
if (hp <= 0) {
    instance_destroy();
}

// CHECK FOR TILE COLLISIONS
EnemyCollisionCorrect();

// ADJUST DIRECTION AND IMAGE ANGLE
direction = (direction + 360) mod 360;
targetDir = (targetDir + 360) mod 360;
var ddif = targetDir - direction;
if (abs(ddif) < turnRate) {
    direction = targetDir;
}
else if (abs(ddif) <= 180) {
    direction += turnRate * sign(ddif);
}
else {
    direction -= turnRate * sign(ddif);
}
image_angle = direction;

// ADJUST DEPTH
if (canSeePlayer && point_distance(x, y, obj_player.x, obj_player.y) <= CELL_SIZE * 0.8) {
    depth = -2000;
}
else {
    depth = 2000;
}
//speed = 0;
