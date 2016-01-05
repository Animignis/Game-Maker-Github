//timers
canMove = true;
canShoot = true;
shotTimer = -1;
shotTimerCap = room_speed * 0.2;
flameTimerCap = room_speed * 0.1;

canShoot2 = true;
shotTimer2 = -1;
shotTimerCap2 = shotTimerCap * 5;

swordTimer = -1;
swordTimerCap = room_speed * 10;

hurt = false;
hurtTimer = -1;
hurtTimerCap = room_speed * 1;

sprSwitchTimer = -1;
sprSwitchTimerCap = room_speed * 0.06;

var blindFadeIn = 0.2;
var blinded = 2.5;
var blindFadeOut = 0.75;
blindAlpha = 0;
blindAlphaFade = false;
blindAlphaUp = 1/(room_speed * blindFadeIn);
blindAlphaDown = 1/(room_speed * blindFadeOut);
blindAlphaTimer = 0;
blindAlphaTimerCap = room_speed * blinded;

blind = false;
blindTimer = -1;
blindTimerCap = room_speed * (blindFadeIn + blindFadeOut + blinded);

stunned = false;
stunTimer = -1;
stunTimerShortCap = room_speed * 1;
stunTimerLongCap = room_speed * 2;

recover = false;
recoverRate = maxHealth * 0.01;
recoverTimer = -1;
recoverTimerCap = room_speed * 5;

slowed = false;
slowTimer = -1;
slowTimerCap = room_speed * 0.2;

charge = false;
chargeTimer = -1;
chargeTimerCap = room_speed * 0.75;

poisoned = false;
poisonTimer = -1;
poisonTimerCap = room_speed * 0.2;