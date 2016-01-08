//with(other) { instance_destroy(); }
if (fullSpawn && !hurt && !stunned && weapon != wpn_sword) {
    health -= other.damage;
    switch (other.c) {
        case c_yellow:
        stunned = true;
        stunTimer = stunTimerShortCap;
        break;
        
        case c_lime:
        slowed = true;
        slowTimer = slowTimerCap;
        break;
        
        case c_purple:
        poisoned = true;
        poisonTimer = poisonTimerCap;
        recoverTimer = recoverTimerCap;
        break;
    }
}
