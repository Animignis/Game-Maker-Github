PlayerDesktopMove();

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

/*
var a = collision_line(
    x + lengthdir_x(checkDistA, direction),
    y + lengthdir_y(checkDistA, direction), 
    x + lengthdir_x(checkDistB, direction),
    y + lengthdir_y(checkDistB, direction),
    obj_block, true, true);
var b = collision_line(
    x + lengthdir_x(checkDistA, direction + 45),
    y + lengthdir_y(checkDistA, direction + 45), 
    x + lengthdir_x(checkDistB, direction + 45),
    y + lengthdir_y(checkDistB, direction + 45),
    obj_block, true, true);
var c = collision_line(
    x + lengthdir_x(checkDistA, direction - 45),
    y + lengthdir_y(checkDistA, direction - 45), 
    x + lengthdir_x(checkDistB, direction - 45),
    y + lengthdir_y(checkDistB, direction - 45),
    obj_block, true, true);
*/

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

if (a || b || c) {
    with(obj_shader_set) {
        wobTimer = 1;
    }
}
else {
    with(obj_shader_set) {
        wobTimer = -1;
    }
}