if (hurtTimer >= 0) {
    hurtTimer -= 1;
    if (hurtTimer == -1) {
        state = prevDifState;
    }
}
