if (weapon != wpn_sword) {
    if(mouse_wheel_up() || keyboard_check_pressed(ord('E'))) {
        windex += 1;
    }
    else if (mouse_wheel_down() || keyboard_check_pressed(ord('Q'))) {
        windex -= 1;
    }
    
    if (windex >= ds_list_size(wswap)) {
        windex = 0;
    }
    else if (windex < 0) {
        windex = ds_list_size(wswap) - 1;
    }
    
    weapon = ds_list_find_value(wswap, windex);
}
