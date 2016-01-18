event_inherited();
EnemySetSprites(
    sprite_index,
    sprite_index,
    sprite_index,
    spr_chompWhite);
EnemySetImageSpeeds(
    0.1,
    0.15,
    0.3,
    0);

color = c_red;

maxSpeed = 5;

dmg = 10;
hp = 40;

sightRange = 16 * CELL_SIZE;
sightAngle = 60;

attackRange = 10 * CELL_SIZE;
attackSpeed = 13;

attackStartCap = 1 * room_speed;
attackTimerCap = 0.8 * room_speed;
attackStart = attackStartCap;
attackTimer = attackTimerCap;

image_speed = imgSpeeds[state];

val = 5;
