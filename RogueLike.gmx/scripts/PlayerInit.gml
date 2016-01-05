maxSpeed = 6;
image_speed = 0;
health = 100;

// collision vars
collisionDist = 12/32 * CELL_SIZE;
a = 0;
b = 0;
c = 0;

PlayerInitWeapons();
PlayerInitTimers();

c = floor(x / CELL_SIZE);
r = floor(y / CELL_SIZE);
pc = -1;
pr = -1;

PlayerInitParticles();
