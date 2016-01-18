// MOVEMENT
maxSpeed = 7;
speed = 0;
collisionDist = floor(13/32 * CELL_SIZE);
turnRate = 5;
targetDir = direction;

// STATISTICS AND PROPERTIES
hp = 20;
val = 3;
dmg = 5;
spawned = false;
invincible = false;

// SIGHT
sightRange = CELL_SIZE * 20;
sightAngle = 48;
canSeePlayer = false; // see SetPrevNextEdges
hasSetCanSeePlayer = false; // see SetPrevNextEdges
lostSightCount = 0;
lostSightCap = 2 * room_speed;

// STATE MACHINE
WANDER = 0;
CHASE = 1;
ATTACK = 2;
HURT = 3;
state = WANDER;
prevState = WANDER;
prevDifState = WANDER;

// WANDER
wanderChance = 0.05;

// CHASE
chaseRange = CELL_SIZE * 20;

// ATTACK
attackRange = CELL_SIZE * 0.75;
attackStart = true;

// HURT
hurtTimerCap = 0.15 * room_speed;
hurtTimer = -1;

// SET SPRITES STUFF
EnemySetSprites(
    sprite_index,
    sprite_index,
    spr_zomb_attack,
    spr_zombWhite);
EnemySetImageSpeeds(
    0,
    0,
    0.16,
    0);

// PARTICLES
color = c_lime;

