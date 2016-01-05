event_inherited();

deathTimer--;

if (deathTimer <= 0) {
    instance_destroy();
}

if (speed > 0) {
    speed -= decel;
} else {
    speed = 0;
}

sizeFactor += sizeFactorAdjust;
if (sizeFactor > sizeFactorAdjustCap) {
    sizeFactor = sizeFactorAdjustCap;
}
image_xscale = sizeFactor;
image_yscale = image_xscale;

repeat (5)
{
part_particles_create(ps,

x-size*sizeFactor*0.5+random(size * sizeFactor),
y-size*sizeFactor*0.5+random(size * sizeFactor),

pt_fire,1);
}