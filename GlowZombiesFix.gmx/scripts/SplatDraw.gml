draw_self();
repeat (1)
{
var ran;
ran=random(360);

part_particles_create(ps,

x+lengthdir_x(random(18),ran),
y+lengthdir_y(random(18),ran),

pt_splat,1);
}