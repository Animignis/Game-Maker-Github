image_alpha -= da;

if (image_alpha <= 0.1) {
    instance_destroy();
}

image_blend = c;
part_type_color3(pt_splat,c,c,c_white);