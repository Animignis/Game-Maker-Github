#define Enemy
max_speed = 3;
speed = 0;
a = 0.1;

chaseRange = view_wview / 2;
collisionDist = 13;

#define EnemyControl
var px = obj_player.x;
var py = obj_player.y;
var dir = point_direction(x, y, px, py);
direction = round(dir / 45) * 45;
image_angle = dir;
if (point_distance(x, y, px, py) <= chaseRange) {
    speed = max_speed;
    EnemyCollisionCorrect();
}
else {
    speed = 0;
}

#define EnemyCollisionCorrect
//collision checking
var checkDistA = collisionDist - speed;
var checkDistB = collisionDist;

var a, b, c, ax, bx, cy, ay, by, cy;
ax = x + lengthdir_x(checkDistB, direction);
ay = y + lengthdir_y(checkDistB, direction);
bx = x + lengthdir_x(checkDistB, direction + 45);
by = y + lengthdir_y(checkDistB, direction + 45);
cx = x + lengthdir_x(checkDistB, direction - 45);
cy = y + lengthdir_y(checkDistB, direction - 45);
a = CheckTile(ax, ay);
b = CheckTile(bx, by);
c = CheckTile(cx, cy);

aax = ax;
aay = ay;
bbx = bx;
bby = by;
ccx = cx;
ccy = cy;

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
/*
if (a && b && c) {
    var playerDir = 
        point_direction(x, y, obj_player.x, obj_player.y);
    direction += 90 * sign(playerDir - direction);
    speed = max_speed;
}
*/

#define EnemyDraw
draw_self();