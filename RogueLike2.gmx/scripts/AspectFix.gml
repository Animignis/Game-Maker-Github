var wv = view_wview;
var hv = view_hview;
var wp = view_wport;
var hp = view_hport;

var dw = display_get_width();
var dh = display_get_height();
var aspect = dw / dh;

if (window_get_fullscreen()) {
    view_wport = dw;
    view_hport = dw / aspect;
    
    view_hview = view_wview / aspect;
}
else {
    view_wport = view_wview;
    view_hport = view_wview / aspect;
    
    view_hview = view_hport;
}
