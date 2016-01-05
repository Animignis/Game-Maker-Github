speed = maxSpeed;
if (keyboard_check(ord('A')) && keyboard_check(ord('S'))) {
    direction = 225;
}
else if (keyboard_check(ord('A')) && keyboard_check(ord('W'))) {
    direction = 135;
}
else if (keyboard_check(ord('D')) && keyboard_check(ord('S'))) {
    direction = 315;
}
else if (keyboard_check(ord('D')) && keyboard_check(ord('W'))) {
    direction = 45;
}
else {
    if (keyboard_check(ord('D'))) {
        direction = 0;
    }
    else if (keyboard_check(ord('W'))) {
        direction = 90;
    }
    else if (keyboard_check(ord('A'))) {
        direction = 180;
    }
    else if (keyboard_check(ord('S'))) {
        direction = 270;
    }
    else {
        speed = 0;
    }
}