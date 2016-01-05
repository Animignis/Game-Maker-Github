//effect_create_above(ef_ellipse, x, y, 2, c_aqua);
//movement
dir = 0;
normalmaxspeed = 7;
slowmaxspeed = normalmaxspeed * 0.5;
swordmaxspeed = normalmaxspeed*2;
maxspeed = normalmaxspeed;
myspeed = 0;
fixspeed = 0;
randomize();

PlaySound(snd_entrance);
PlayMusic(snd_music);

//health
maxHealth = 1.5;
health = maxHealth;

PlayerInitTimers();

//sprites
spr_main = spr_player3;
spr_hurt = spr_player3Hurt;
sprite_index = spr_main;

window_set_cursor(cr_none);

//collisions
hbor = sprite_width * 0.3;
vbor = sprite_height * 0.3;

//other
fullSpawn = false;
image_alpha = 0.4;
da = 0.005;

poisonRate = 0.005;

PlayerInitWeapons();

//PARTICLES
PlayerInitParticles();
if (instance_number(obj_playerRespawn) == 0) {
    var respawn = instance_create(0, 0, obj_playerRespawn);
    respawn.maxHealth = maxHealth;
}