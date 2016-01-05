if (slowed) {
    maxspeed = normalmaxspeed * 0.5;
}
else {
    maxspeed = normalmaxspeed;
}

if(weapon == wpn_sword) {
    maxspeed = swordmaxspeed;
}
else if (!slowed) {
    maxspeed = normalmaxspeed;
}

PlayerDesktopMove();

var xmove = lengthdir_x(myspeed, dir);
var ymove = lengthdir_y(myspeed, dir);
var hbor = sprite_width * 0.3;
var vbor = sprite_height * 0.3;
var xcheck = x + xmove + hbor * sign(xmove);
var ycheck = y + ymove + vbor * sign(ymove);
var dx = 0;
var dy = 0;
if (!collision_rectangle(x, y - vbor,
        xcheck, y + vbor, obj_wall,
        false, true)) {
    x += xmove;
    dx = xmove;
}
if (!collision_rectangle(x - hbor, y,
        x + hbor, ycheck, obj_wall,
        false, true)) {
    y += ymove;
    dy = ymove;
}

fixspeed = sqrt(power(dx, 2) + power(dy, 2));