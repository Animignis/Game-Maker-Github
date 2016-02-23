if (canControl) {
    //aim
    image_angle = point_direction(x, y, mouse_x, mouse_y);
    //input speed/direction for PC controls
    PlayerDesktopMove();
}
PlayerCollisionCheck();
