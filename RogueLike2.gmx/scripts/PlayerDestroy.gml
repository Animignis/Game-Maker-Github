Shake(1.5 * room_speed, 16);
with(obj_enemy) {
    EnemyResetState();
}
repeat(100) {
    var ran;
    ran=random(360);
    part_particles_create(ps,
        x+lengthdir_x(random(32),ran),
        y+lengthdir_y(random(32),ran),
        obj_partman.pt_explode_player_squares,1);
}

repeat (10)
{
    var ran;
    ran=random(360);
    
    part_particles_create(ps,
        x+lengthdir_x(random(32),ran),
        y+lengthdir_y(random(32),ran),
        obj_partman.pt_explode_player,1);
}

obj_game.alarm[0] += 2.5 * room_speed;
