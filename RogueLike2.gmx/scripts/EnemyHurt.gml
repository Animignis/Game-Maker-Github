if (hurtTimer > 0) {
    hurtTimer -= 1;
}
else {
    state = prevDifState;
    hurtTimer = -1;
}
