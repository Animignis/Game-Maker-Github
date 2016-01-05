if (ltn_enemy != -1) {
    var chain;
    var possibleChains = ds_list_create();
    ds_list_clear(ltn_chain);
    ds_list_add(ltn_chain, ltn_enemy);
    chain = ltn_enemy;
    var c = 0;
    do {
        var obj = -1;
        var i;
        var n = instance_number(obj_enemy_pa);
        var chainFound = false;
        ds_list_clear(possibleChains);
        for (i = 0; i < n; i++) {
            obj = instance_find(obj_enemy_pa, i);
            var d = point_distance(chain.x,chain.y,obj.x,obj.y);
            //show_debug_message("d: " + string(d));
            //show_debug_message("close: " + string(close));
            //show_debug_message("(ltn_enemy, obj): " + string(ltn_enemy) + ", " + string(obj));
            if (d <= ltn_range && obj != ltn_enemy
                    && ds_list_find_index(ltn_chain, obj) == -1) {
                //chain = obj;
                chainFound = true;
                ds_list_add(possibleChains, obj);
                //show_debug_message(string(d));
            }
        }
        if (!chainFound) {
            chain = -1;
        }
        else {
            obj = ds_list_find_value(possibleChains, floor(random(ds_list_size(possibleChains))));
            ds_list_add(ltn_chain, obj);
            chain = obj;
        }
        c++;
        //show_debug_message("blah " + string(c) + " " + string(chain));
    } until(chain == -1 || c >= ltn_cap);
    ltn_enemy.hp -= weapon_damage[6];
    for (i = 0; i < ds_list_size(ltn_chain) - 1; i++) {
        var obj1 = ds_list_find_value(ltn_chain, i);
        var obj2 = ds_list_find_value(ltn_chain, i+1);
        obj2.hp -= weapon_damage[6] * power(0.75, i+1);
        DrawLightning(obj1.x, obj1.y, obj2.x, obj2.y, 2, 6, 8, 16, c_aqua, 0.8);
        part_particles_create(ps,obj2.x,obj2.y,ptSpark,5);
    }
    ds_list_destroy(possibleChains);
}
else {
    ds_list_clear(ltn_chain);
}
