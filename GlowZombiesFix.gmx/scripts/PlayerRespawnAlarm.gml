if (lives > 0) {
    instance_create(xx,yy, obj_player);
    obj_player.windex = windex;
}
else {
    dead = true;
}
respawn = false;
