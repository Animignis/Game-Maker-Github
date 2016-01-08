{
    /**
    _jso_xwfu_encode_sublist(parent, list): Encode non-top-level JSOnion-compatible list in x-www-form-urlencoded format, with indicated parent.
    Restriction due to x-www-form-urlencoded limitations:
    - Lists cannot have other structures nested inside.
    - All keys must be strings. If they're not, they'll be turned into strings.
    - All structures must have at least one entry, except for the top element.
    - Map keys must not be empty strings.
    */
    var i, l, str;
    l = ds_list_size(argument1);
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
        //Add the "key" (if applicable) and value
        switch (jso_list_get_type(argument1, i)) {
            case jso_type_boolean:
                str += jso_xwfu_encode_string(argument0 + "[]") + "=";
                if (jso_list_get(argument1, i)) {
                    str += "true";
                } else {
                    str += "false";
                }
            break;
            case jso_type_real:
                str += jso_xwfu_encode_string(argument0 + "[]") + "=";
                str += jso_encode_real(jso_list_get(argument1, i));
            break;
            case jso_type_string:
                str += jso_xwfu_encode_string(argument0 + "[]") + "=";
                str += jso_xwfu_encode_string(jso_list_get(argument1, i));
            break;
            case jso_type_map: case jso_type_list:
                show_error("Lists for encoding to x-www-form-urlencoded cannot have further nested structures.", true);
            break;
        }
    }
    
    //Done construction
    return str;
}
