{
    /**
    _jso_xwfu_encode_submap(parent, map): Encode non-top-level JSOnion-compatible map in x-www-form-urlencoded format, with indicated parent.
    Restriction due to x-www-form-urlencoded limitations:
    - Lists cannot have other structures nested inside.
    - All keys must be strings. If they're not, they'll be turned into strings.
    - All structures must have at least one entry, except for the top element.
    - Map keys must not be empty strings.
    */
    var i, l, k, ks, str;
    l = ds_map_size(argument1);
    k = ds_map_find_first(argument1);
    str = "";
    
    //Error if size is 0
    if (l == 0) {
        show_error("All structures for encoding to x-www-form-urlencoded must have at least one entry, except for the top element.", true);
    }
    
    //Loop through all top-level keys
    for (i=0; i<l; i+=1) {
        //Entry separator
        if (i>0) {
            str += "&";
        }
        //Convert the key
        ks = k;
        if (is_real(k)) {
            ks = jso_encode_real(k);
        }
        //Check the key
        if (ks == "") {
            show_error("Maps for encoding to x-www-form-urlencoded cannot have empty strings as keys.", true);
        }
        //Add the key (if applicable) and value
        switch (jso_map_get_type(argument1, k)) {
            case jso_type_boolean:
                str += jso_xwfu_encode_string(argument0 + "[" + ks + "]") + "=";
                if (jso_map_get(argument1, k)) {
                    str += "true";
                } else {
                    str += "false";
                }
            break;
            case jso_type_real:
                str += jso_xwfu_encode_string(argument0 + "[" + ks + "]") + "=";
                str += jso_encode_real(jso_map_get(argument1, k));
            break;
            case jso_type_string:
                str += jso_xwfu_encode_string(argument0 + "[" + ks + "]") + "=";
                str += jso_xwfu_encode_string(jso_map_get(argument1, k));
            break;
            case jso_type_map:
                str += _jso_xwfu_encode_submap(argument0 + "[" + ks + "]", jso_map_get(argument1, k));
            break;
            case jso_type_list:
                str += _jso_xwfu_encode_sublist(argument0 + "[" + ks + "]", jso_map_get(argument1, k));
            break;
        }
        k = ds_map_find_next(argument1, k);
    }
    
    //Done construction
    return str;
}