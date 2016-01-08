// MOVEMENT
max_speed = 4;
speed = 0;

// STATISTICS
hp = 100;

// STATE MACHINE
WANDER = 0;
CHASE = 1;
ATTACK = 2;
HURT = 3;
state = CHASE;

// SET SPRITES
spr = spr_zomb;
hurtSpr = spr_zombWhite;

chaseRange = view_wview * 0.75;
collisionDist = floor(13/32 * CELL_SIZE);

// TIMERS
hurtTimerCap = 6;
hurtTimer = -1;

// PARTICLES
part_type_color3(obj_partman.pt_spawn_enemy,65280,65280,65280);
part_particles_create(ps,x,y,obj_partman.pt_spawn_enemy,1);
