if (ltn_enemy != -1) {
    var chain;
    ds_list_clear(ltn_chain);
    ds_list_add(ltn_chain, ltn_enemy);
    chain = ltn_enemy;
    var c = 0;
    var chainFound;
    do {
        var obj = -1;
        var i;
        var close = obj_player.ltn_range + 1;
        var n = instance_number(obj_enemy_pa);
        chainFound = false;
        var chainList = ds_list_create();
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
                ds_list_add(chainList, obj);
                DrawLightning(chain.x, chain.y, obj.x, obj.y, 2, 6, 8, 16, c_aqua, 0.8);
                part_particles_create(ps,obj.x,obj.y,ptSpark,5);
            }
        }
        if (!chainFound) {
            chain = -1;
        }
        else {
            for (i = 0; i < ds_list_size(chainList); i++) {
                obj = ds_list_find_value(chainList, i);
                DrawLightning(chain.x, chain.y, obj.x, obj.y, 2, 6, 8, 16, c_aqua, 0.8);
                part_particles_create(ps,obj.x,obj.y,ptSpark,5);
            }
        }
        c++;
        //show_debug_message("blah " + string(c) + " " + string(chain));
    } until(!chainFound || c >= 1000);
}

