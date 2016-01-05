{
    /**
    jso_xwfu_encode_string(str): Encode the string <str> in x-www-form-urlencoded format.
    */
    var s;
    s = "";
    
    //Main loop
    var i, l, c;
    l = string_length(argument0);
    for (i=1; i<=l; i+=1) {
        c = string_char_at(argument0, i);
        //Single-byte characters
        if (ord(c) < 128) {
            switch (c) {
                case "$": c = "%24"; break;
                case "&": c = "%26"; break;
                case "+": c = "%2B"; break;
                case ",": c = "%2C"; break;
                case "/": c = "%2F"; break;
                case ":": c = "%3A"; break;
                case ";": c = "%3B"; break;
                case "=": c = "%3D"; break;
                case "!": c = "%21"; break;
                case "?": c = "%3F"; break;
                case "@": c = "%40"; break;
                case " ": c = "%20"; break;
                case '"': c = "%22"; break;
                case "'": c = "%27"; break;
                case "<": c = "%3C"; break;
                case ">": c = "%3E"; break;
                case "#": c = "%23"; break;
                case "%": c = "%25"; break;
                case "{": c = "%7B"; break;
                case "}": c = "%7D"; break;
                case "|": c = "%7C"; break;
                case "\": c = "%5C"; break;
                case "^": c = "%5E"; break;
                case "~": c = "%7E"; break;
                case "[": c = "%5B"; break;
                case "]": c = "%5D"; break;
                case "`": c = "%60"; break;
            }
        }
        //Multi-byte characters
        else {
            c = _jso_xwfu_char_to_urlutf8(c);
        }
        s += c;
    }
    
    //Done
    return s;
}