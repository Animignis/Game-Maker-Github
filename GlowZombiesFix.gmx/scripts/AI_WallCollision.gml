var ang = abs(direction) mod 360;

x += lengthdir_x(speed * 1.5, direction + 180);
y += lengthdir_y(speed * 1.5, direction + 180);

if (other.object_index == obj_vwall) {
    if (ang > 270) {
        ang -= 360;
    }
    direction = 180 - ang;
}
else if (other.object_index == obj_hwall) {
    direction = 360 - ang;
}

direction = abs(direction) mod 360;
