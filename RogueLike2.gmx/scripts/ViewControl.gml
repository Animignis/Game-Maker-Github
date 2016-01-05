var s = 16;
if (keyboard_check(vk_left)) {
    view_xview -= s;
}
else if (keyboard_check(vk_right)) {
    view_xview += s;
}

if (keyboard_check(vk_up)) {
    view_yview -= s;
}
else if (keyboard_check(vk_down)) {
    view_yview += s;
}

if (mouse_wheel_up()) {
    vscale -= dvs;
}
else if (mouse_wheel_down()) {
    vscale += dvs;
}

if (vscale < vscale_min) {
    vscale = vscale_min;
}
else if (vscale > vscale_max) {
    vscale = vscale_max;
}

view_wview = vwi * vscale;

AspectFix();