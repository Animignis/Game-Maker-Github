{
    /**
    _jso_xwfu_pct_0x(int): Convert an integer to hexadecimal string form, then prepend a % to it.
    */
    {
      var hex_digits, n, result;
      hex_digits = "0123456789ABCDEF";
      n = argument0;
      result = "";
      do {
        result = string_char_at(hex_digits, 1+n mod 16) + result;
        n = n div 16;
      } until (n == 0);
      return "%" + result;
    }
}
