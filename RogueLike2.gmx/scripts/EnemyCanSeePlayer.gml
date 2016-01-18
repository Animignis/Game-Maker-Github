var count = ds_list_size(eg);
for (var k = 0; k < count; k+= 6) {
    var x1 = eg[| k];
    var y1 = eg[| k+1];
    var x2 = eg[| k+2];
    var y2 = eg[| k+3];
    var t = LineSegmentsIntersect(
        x1, y1, x2, y2, x, y, obj_player.x, obj_player.y);
    
}
