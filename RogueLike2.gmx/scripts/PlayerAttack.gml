part_type_direction(pt_flash,image_angle-10,image_angle+10,0,0);
switch(weapon) {
    case wpn_pistol:
    part_type_color3(pt_flash,c_white,c_aqua,c_aqua);
    var b = instance_create(
        x + lengthdir_x(collisionDist, image_angle),
        y + lengthdir_y(collisionDist, image_angle), obj_bullet);
    part_particles_create(ps,b.x,b.y,pt_flash,20);
    break;
}
