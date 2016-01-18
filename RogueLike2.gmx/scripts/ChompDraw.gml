if (state == ATTACK && attackStart < 0){
    part_type_orientation(pt_chomp_blur,direction,direction,0,0,0);
    part_particles_create(ps, x, y, pt_chomp_blur, 1);
}
