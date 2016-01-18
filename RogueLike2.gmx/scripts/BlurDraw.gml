draw_set_blend_mode(bm_normal);
draw_set_color(c_white);
var a = alpha;
var i, ax, ay;
imgInd = 0;
if (ind != len - 1) {
    for (i = ind - 1; i >= 0; i--) {
        ax = xx[i];
        ay = yy[i];
        draw_sprite_ext(spr, imgInd, ax, ay, 1, 1, blurRot, blend, a);
        imgInd = (imgInd + 1) mod imgMax;
        if (decAlpha) {
            a -= da;
        }
    }
    for (i = len - 1; i > ind + 1; i--) {
        ax = xx[i];
        ay = yy[i];
        draw_sprite_ext(spr, imgInd, ax, ay, 1, 1, blurRot, blend, a);
        imgInd = (imgInd + 1) mod imgMax;
        if (decAlpha) {
            a -= da;
        }
    }
}
else {
    for (i = ind - 1; i > 0; i--) {
        ax = xx[i];
        ay = yy[i];
        draw_sprite_ext(spr, imgInd, ax, ay, 1, 1, blurRot, blend, a);
        imgInd = (imgInd + 1) mod imgMax;
        if (decAlpha) {
            a -= da;
        }
    }
}

draw_primitive_end();
