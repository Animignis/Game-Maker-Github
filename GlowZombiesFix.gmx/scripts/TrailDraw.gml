draw_set_color(c_white);
var r = radius;
var alpha = startAlpha;
var da = (1 / len) * alpha;
var i, ax, ay, bx, by, angle;
var tex = sprite_get_texture(spr_test, 0);
//draw_circle_color(x,y,r, c_yellow, c_yellow, false);
draw_primitive_begin(pr_trianglestrip);
//draw_primitive_begin_texture(pr_trianglestrip, tex);
if (ind != len - 1) {
    for (i = ind - 1; i >= 0; i--) {
        ax = xx[i];
        ay = yy[i];
        if (i == 0) {
            bx = xx[len - 1];
            by = yy[len - 1];
        }
        else {
            bx = xx[i - 1];
            by = yy[i - 1];
        }
        angle = point_direction(ax,ay,bx,by);
        
        draw_vertex_color(ax + lengthdir_x(r, angle + 90),
            ay + lengthdir_y(r, angle + 90), c, alpha);
        draw_vertex_color(ax + lengthdir_x(r, angle - 90),
            ay + lengthdir_y(r, angle - 90), c, alpha);/*
        draw_vertex_texture_color(ax + lengthdir_x(r, angle + 90),
            ay + lengthdir_y(r, angle + 90), 32, 32, c, alpha);
        draw_vertex_texture_color(ax + lengthdir_x(r, angle - 90),
            ay + lengthdir_y(r, angle - 90), 32, 32, c, alpha);*/
        if (decAlpha) {
            alpha -= da;
        }
        if (decRad) {
            r -= dr;
        }
    }
    for (i = len - 1; i > ind + 1; i--) {
        ax = xx[i];
        ay = yy[i];
        bx = xx[i - 1];
        by = yy[i - 1];
        angle = point_direction(ax,ay,bx,by);
        draw_vertex_color(ax + lengthdir_x(r, angle + 90),
            ay + lengthdir_y(r, angle + 90), c, alpha);
        draw_vertex_color(ax + lengthdir_x(r, angle - 90),
            ay + lengthdir_y(r, angle - 90), c, alpha);/*
        draw_vertex_texture_color(ax + lengthdir_x(r, angle + 90),
            ay + lengthdir_y(r, angle + 90), 32, 32, c, alpha);
        draw_vertex_texture_color(ax + lengthdir_x(r, angle - 90),
            ay + lengthdir_y(r, angle - 90), 32, 32, c, alpha);*/
        if (decAlpha) {
            alpha -= da;
        }
        if (decRad) {
            r -= dr;
        }
    }
    draw_vertex_color(xx[ind + 1], yy[ind + 1], c, alpha);
    /*if (!decRad) {
        draw_set_alpha(alpha);
        draw_circle_color(xx[ind + 1], yy[ind + 1], r, c, c, false);
        draw_set_alpha(1);
    }*/
    //draw_vertex_texture_color(xx[ind + 1], yy[ind + 1], 32, 32, c, alpha);
}
else {
    for (i = ind - 1; i > 0; i--) {
        ax = xx[i];
        ay = yy[i];
        bx = xx[i - 1];
        by = yy[i - 1];
        angle = point_direction(ax,ay,bx,by);
        draw_vertex_color(ax + lengthdir_x(r, angle + 90),
            ay + lengthdir_y(r, angle + 90), c, alpha);
        draw_vertex_color(ax + lengthdir_x(r, angle - 90),
            ay + lengthdir_y(r, angle - 90), c, alpha);
        /*draw_vertex_texture_color(ax + lengthdir_x(r, angle + 90),
            ay + lengthdir_y(r, angle + 90), 32, 32, c, alpha);
        draw_vertex_texture_color(ax + lengthdir_x(r, angle - 90),
            ay + lengthdir_y(r, angle - 90), 32, 32, c, alpha);*/
        if (decAlpha) {
            alpha -= da;
        }
        if (decRad) {
            r -= dr;
        }
    }
    draw_vertex_color(xx[0], yy[0], c, alpha);
    /*if (!decRad) {
        draw_set_alpha(alpha);
        draw_circle_color(xx[0], yy[0], r, c, c, false);
        draw_set_alpha(1);
    }*/
    //draw_vertex_texture_color(xx[0], yy[0], 32, 32, c, alpha);
}

draw_primitive_end();