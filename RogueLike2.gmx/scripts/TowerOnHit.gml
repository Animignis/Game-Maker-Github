var dmg = argument0;
hp -= dmg;
hurt = 4;

if (hp <= 0) {
    instance_destroy();
}
