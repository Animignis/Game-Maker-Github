switch(object_index) {
    case obj_chomp:
        ChompDraw();
        break;
}

draw_self();
/*
if (canSeePlayer) {
    var d1 = direction + sightAngle;
    var d2 = direction - sightAngle;
    draw_triangle(x,y,x+lengthdir_x(sightRange, d1),y+lengthdir_y(sightRange, d1),
            x+lengthdir_x(sightRange, d2),y+lengthdir_y(sightRange, d2), true);
    draw_line(x, y, x + lengthdir_x(64, targetDir), y + lengthdir_y(64, targetDir));
}
*/


