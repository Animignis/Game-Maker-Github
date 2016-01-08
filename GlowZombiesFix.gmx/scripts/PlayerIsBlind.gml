if (blindAlpha >= 1 && !blindAlphaFade) {
    blindAlphaTimer++;
    blindAlpha = 1;
    if (blindAlphaTimer >= blindAlphaTimerCap) {
        blindAlphaTimer = 0;
        blindAlphaFade = true;
    }
}

if (blindAlphaFade) {
    blindAlpha -= blindAlphaDown;
}
else if (blindAlpha < 1){
    blindAlpha += blindAlphaUp;
}

draw_set_alpha(blindAlpha);
//draw_circle(x,y,blindR, false);

draw_rectangle_color(view_xview, view_yview, 
    view_xview + view_wview, view_yview + view_hview,
    c_black, c_black, c_black, c_black, false);
draw_set_alpha(1);
