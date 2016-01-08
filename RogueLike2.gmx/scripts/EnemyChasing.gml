var px = obj_player.x;
var py = obj_player.y;
var dir = point_direction(x, y, px, py);
direction = dir;
image_angle = dir;
var dist = point_distance(x, y, px, py);
if (dist <= chaseRange && dist > CELL_SIZE * 0.5) {
    speed = max_speed;
    EnemyCollisionCorrect();
}
else {
    speed = 0;
}
