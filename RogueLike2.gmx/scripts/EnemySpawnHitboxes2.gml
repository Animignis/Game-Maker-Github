var hb1 = instance_create(
    x + lengthdir_x(26, direction + 20),
    y + lengthdir_y(26, direction + 20),
    obj_hitbox);
hb1.delay = 0/attackImageSpeed;
hb1.size = 14;
hb1.dmg = dmg;
var hb2 = instance_create(
    x + lengthdir_x(26, direction - 20),
    y + lengthdir_y(26, direction - 20),
    obj_hitbox);
hb2.delay = 2/attackImageSpeed;
hb2.size = 14;
hb2.dmg = dmg;
