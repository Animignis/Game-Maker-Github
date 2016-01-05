#define Enemy
max_speed = 3;
speed = 0;
a = 0.1;

chaseRange = view_wview / 3;
collisionDist = 13;

px = x;
py = y;

a = 0;
b = 0;
c = 0;
ax = 0;
ay = 0;
bx = 0;
by = 0;
cx = 0;
cy = 0;

#define EnemyControl
var px = obj_player.x;
var py = obj_player.y;

direction = point_direction(x, y, px, py);
direction = round(direction / 45) * 45;
image_angle = direction;
if (point_distance(x, y, px, py) <= chaseRange) {
    speed += a;
    if (speed > max_speed) {
        speed = max_speed;
    }
    EnemyCollisionCorrect();
}
else {
    speed = 0;
}

#define EnemyCollisionCorrect
//collision checking
var checkDistA = collisionDist - speed;
var checkDistB = collisionDist;

ax = x + lengthdir_x(checkDistB, direction);
ay = y + lengthdir_y(checkDistB, direction);
bx = x + lengthdir_x(checkDistB, direction + 45);
by = y + lengthdir_y(checkDistB, direction + 45);
cx = x + lengthdir_x(checkDistB, direction - 45);
cy = y + lengthdir_y(checkDistB, direction - 45);
a = CheckTile(ax, ay);
b = CheckTile(bx, by);
c = CheckTile(cx, cy);

if (b && c) {
    speed = 0;
    direction -= 180;
}
else if (b && !c) {
    direction -= 45;
}
else if (c &&!b) {
    direction += 45;
}
else if (b && !c) {
    direction -= 45;
    speed = 0;
}
else if (c && !b) {
    direction += 45;
    speed = 0;
}

if (speed == 0 && a && b && c) {
    var playerDir = 
        point_direction(x, y, obj_player.x, obj_player.y);
    direction += 90 * sign(playerDir - direction);
}

#define EnemyDraw
draw_self();

draw_point(ax, ay);
draw_point(bx, by);
draw_point(cx, cy);
