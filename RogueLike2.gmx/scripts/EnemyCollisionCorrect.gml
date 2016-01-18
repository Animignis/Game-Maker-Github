//collision checking
var dd = collisionDist + speed;

var a, b, c, ax, bx, cy, ay, by, cy;
var cdir = round(direction / 45) * 45;
ax = x + lengthdir_x(dd, cdir);
ay = y + lengthdir_y(dd, cdir);
bx = x + lengthdir_x(dd, cdir + 45);
by = y + lengthdir_y(dd, cdir + 45);
cx = x + lengthdir_x(dd, cdir - 45);
cy = y + lengthdir_y(dd, cdir - 45);
a = CheckTile(ax, ay);
b = CheckTile(bx, by);
c = CheckTile(cx, cy);

if (b && c) {
    speed = 0;
    direction = cdir - 180;
    targetDir = direction - 180;
}
else if (b && !c) {
    direction = cdir - 45;
    targetDir = direction;
}
else if (c &&!b) {
    direction = cdir + 45;
    targetDir = direction;
}
/*
else if (b && !c) {
    direction -= 45;
    targetDir = direction;
    speed = 0;
}
else if (c && !b) {
    direction += 45;
    targetDir = direction;
    speed = 0;
}
*/
