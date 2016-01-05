{
    /**
    _jso_xwfu_char_to_urlutf8(char): Convert character <char> to x-www-form-urlencoded form in UTF-8.
    Source: http://stackoverflow.com/questions/1805802/php-convert-unicode-codepoint-to-utf-8
    */

    var o;
    o = ord(argument0);
    
    //1-byte
    if (o <= $7F) {
        return _jso_xwfu_pct_0x(o);
    }
    //2-byte
    else if (o <= $7FF) {
        return _jso_xwfu_pct_0x((o>>6)+192) + _jso_xwfu_pct_0x((o&63)+128);
    }
    //3-byte
    else if (o <= $FFFF) {
        return _jso_xwfu_pct_0x((o>>12)+224) + _jso_xwfu_pct_0x(((o>>6)&63)+128) + _jso_xwfu_pct_0x((o&63)+128);
    }
    //4-byte (Not supported in GMS)
    /*else if (o <= $1FFFFF) {
        return _jso_xwfu_pct_0x((o>>18)+240) + _jso_xwfu_pct_0x(((o>>12)&63)+128) + _jso_xwfu_pct_0x(((o>>6)&63)+128) + _jso_xwfu_pct_0x((o&63)+128);
    }*/
    //Too long (4-byte characters are part of the standard, but not supported in GMS, so this case will catch that too)
    else {
        show_error("Invalid character U+" + string(o), true)
    }
}