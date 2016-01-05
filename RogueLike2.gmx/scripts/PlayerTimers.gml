for (var i = 0; i < numWeapons; i++) {
    if (attackTimers[i] > 0) {
        attackTimers[i]--;
    }
    else if (attackTimers[i] == 0) {
        attackTimers[i] = -1;
        canAttack[i] = true;
    }
}