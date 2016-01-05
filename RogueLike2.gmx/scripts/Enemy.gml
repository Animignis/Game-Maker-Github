#define Enemy
max_speed = 4;
speed = 0;

hp = 100;

IDLE = 0;
CHASE = 1;
ATTACK = 2;
HURT = 3;

state = CHASE;

spr = spr_zomb;
hurtSpr = spr_zombWhite;

chaseRange = view_wview * 0.75;
collisionDist = floor(13/32 * CELL_SIZE);

hurtTimerCap = 6;
hurtTimer = -1;

EnemyParticlesInit();

part_particles_create(ps,x,y,pt_spawn,1);

#define EnemyParticlesInit
pt_die=part_type_create();
part_type_shape(pt_die,2);
part_type_size(pt_die,0.60,0.60,-0.02,0);
part_type_scale(pt_die,0.75,0.75);
part_type_orientation(pt_die,0,0,10,90,0);
part_type_direction(pt_die,0,360,0,0);
part_type_speed(pt_die,10,15,-0.2,0);
part_type_gravity(pt_die,0,270);
part_type_color3(pt_die,9568145,4652870,65280);
part_type_alpha3(pt_die,1,0.60,0.20);
part_type_blend(pt_die,1);
part_type_life(pt_die,25,75);

pt_explode=part_type_create();
part_type_shape(pt_explode,6);
part_type_size(pt_explode,0.3,0.6,0.175,0);
part_type_scale(pt_explode,0.70,1);
part_type_orientation(pt_explode,0,360,0,5,0);
part_type_direction(pt_explode,0,360,0,0);
part_type_speed(pt_explode,0.50,1,0,0);
part_type_gravity(pt_explode,0,270);
part_type_color3(pt_explode,16777215,65280,32768);
part_type_alpha3(pt_explode,1,0.50,0);
part_type_blend(pt_explode,1);
part_type_life(pt_explode,20,40);

pt_spawn=part_type_create();
part_type_shape(pt_spawn,6);
part_type_size(pt_spawn,0.10,0.10,0.50,0);
part_type_scale(pt_spawn,1,1);
part_type_orientation(pt_spawn,0,0,0,0,0);
part_type_direction(pt_spawn,0,360,0,0);
part_type_speed(pt_spawn,0,0,0,0);
part_type_gravity(pt_spawn,0,270);
part_type_color3(pt_spawn,65280,65280,65280);
part_type_alpha3(pt_spawn,1,0.50,0);
part_type_blend(pt_spawn,1);
part_type_life(pt_spawn,15,15);

#define EnemyControl
switch(state) {
    case CHASE:
        EnemyChase();
        break;
        
    case HURT:
        EnemyHurt();
        break;
    
    case ATTACK:
        EnemyAttack();
        break;
}

if (hp <= 0) {
    instance_destroy();
}

#define EnemyCollisionCorrect
//collision checking
var checkDistA = collisionDist - speed;
var checkDistB = collisionDist + speed;

var a, b, c, ax, bx, cy, ay, by, cy;
ax = x + lengthdir_x(checkDistB, direction);
ay = y + lengthdir_y(checkDistB, direction);
bx = x + lengthdir_x(checkDistB, direction + 45);
by = y + lengthdir_y(checkDistB, direction + 45);
cx = x + lengthdir_x(checkDistB, direction - 45);
cy = y + lengthdir_y(checkDistB, direction - 45);
a = CheckTile(ax, ay);
b = CheckTile(bx, by);
c = CheckTile(cx, cy);

if (b && c) {
    speed = 0;
    direction -= 180;
}
else if (b && !c) {
    direction -= 45;
}
else if (c &&!b) {
    direction += 45;
}
else if (b && !c) {
    direction -= 45;
    speed = 0;
}
else if (c && !b) {
    direction += 45;
    speed = 0;
}
/*
if (a && b && c) {
    var playerDir = 
        point_direction(x, y, obj_player.x, obj_player.y);
    direction += 90 * sign(playerDir - direction);
    speed = max_speed;
}
*/

#define EnemyDraw
draw_self();
#define EnemyChase
var px = obj_player.x;
var py = obj_player.y;
var dir = point_direction(x, y, px, py);
direction = round(dir / 45) * 45;
image_angle = dir;
var dist = point_distance(x, y, px, py);
if (dist <= chaseRange && dist > CELL_SIZE * 0.5) {
    speed = max_speed;
    EnemyCollisionCorrect();
}
else {
    speed = 0;
}

#define EnemyAttack

#define EnemyHurt
if (hurtTimer > 0) {
    hurtTimer -= 1;
}
else {
    state = CHASE;
    sprite_index = spr;
    hurtTimer = -1;
}

#define EnemyHit
var dmg = argument0;

state = HURT;
sprite_index = hurtSpr;
speed = 0;
hurtTimer = hurtTimerCap;

hp -= dmg

#define EnemyDestroy
var xx = x;
var yy = y;
with(obj_splatters) {
    AddSplat(xx, yy, 80);
}

repeat(20) {
    var ran;
    ran=random(360);
    part_particles_create(ps,
        x+lengthdir_x(random(32),ran),
        y+lengthdir_y(random(32),ran),
        pt_die,1);
}

repeat (5)
{
    var ran;
    ran=random(360);
    
    part_particles_create(ps,
        x+lengthdir_x(random(32),ran),
        y+lengthdir_y(random(32),ran),
        pt_explode,1);
}
