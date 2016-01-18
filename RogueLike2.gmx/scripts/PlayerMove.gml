PlayerDesktopMove();

//collision checking
var checkDist = collisionDist + speed;
var cdir = round(direction / 45) * 45;
ax = x + lengthdir_x(checkDist, cdir);
ay = y + lengthdir_y(checkDist, cdir);
bx = x + lengthdir_x(checkDist, cdir + 45);
by = y + lengthdir_y(checkDist, cdir + 45);
cx = x + lengthdir_x(checkDist, cdir - 45);
cy = y + lengthdir_y(checkDist, cdir - 45);
a = CheckTile(ax, ay);
b = CheckTile(bx, by);
c = CheckTile(cx, cy);

if (b && c) {
    speed = 0;
    direction = cdir - 180;
}
else if (b && !c) {
    direction = cdir - 45;
}
else if (c && !b) {
    direction = cdir + 45;
}

if (a || b || c) {
    with(obj_shader_set) {
        //wobTimer = 1;
    }
}
else {
    with(obj_shader_set) {
        wobTimer = -1;
    }
}
