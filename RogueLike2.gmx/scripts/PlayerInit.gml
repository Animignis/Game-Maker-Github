maxSpeed = 6;
image_speed = 0;
health = 100;

// collision vars
collisionDist = floor(12/32 * CELL_SIZE);
a = 0;
b = 0;
c = 0;

PlayerInitWeapons();
PlayerInitTimers();

col = floor(x / CELL_SIZE);
row = floor(y / CELL_SIZE);
pc = -1;
pr = -1;

PlayerInitParticles();