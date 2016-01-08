switch(state) {
    case WANDER:
        EnemyWandering();
        break;
    case CHASE:
        EnemyChasing();
        break;
        
    case HURT:
        EnemyHurting();
        break;
    
    case ATTACK:
        EnemyAttacking();
        break;
}

if (hp <= 0) {
    instance_destroy();
}
