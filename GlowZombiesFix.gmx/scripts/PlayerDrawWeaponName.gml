var txt;
switch(argument0) {
    case 0:
    txt = "Single Shot";
    break;
    
    case 1:
    txt = "Double Shot";
    break;
    
    case 2:
    txt = "Triple Shot";
    break;
    
    case 3:
    txt = "Firewall";
    break;
    
    case wpn_sword:
    txt = "Sword";
    break;
    
    case 5:
    txt = "Laser";
    break;
    
    case 6:
    txt = "Tesla";
    break;
    
    case 8:
    txt = "Doge";
    break;
    
    case 9:
    txt = "burst";
    break;
}

draw_set_halign(fa_right);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_font(fnt_score);
draw_text(view_xview + view_wview, view_yview, string(txt));