/*
************
Weapons
************
pistol

TODO:
rifle
shotgun

missiles
bombs/grenades
mines

flame thrower
laser
tesla

boomerang
grapling hook
sword
hammer
flail
sludge spill

flash
time sphere

turrets??
*/

weapon = 0;
numWeapons = 4;

canAttack = true;

attackTimerCaps[0] = 0.25*room_speed;   // pistol (damage, hitstun)
attackTimerCaps[1] = 4*room_speed;      // dodge (defense)
attackTimerCaps[2] = 3*room_speed;      // pulse wave (damage, hitstun, piercing, wide arc, short/mid range/life)
attackTimerCaps[3] = 20*room_speed;     // ?????

for (var i = 0; i < numWeapons; i++) {
    attackTimers[i] = -1;
}
