var count = ds_list_size(eg);
var thresh = 0;
var px = playerX;
var py = playerY;
for (var k = 0; k < count; k+= 6) {
    var x1 = eg[| k];
    var y1 = eg[| k+1];
    var x2 = eg[| k+2];
    var y2 = eg[| k+3];
    var pe = -1;
    var ne = -1;
    if (instance_exists(obj_player)) {
        with(obj_enemy) {
            if (!hasSetCanSeePlayer) {
                var lsi = LineSegmentsIntersect(
                    x1, y1, x2, y2, x, y, px, py);
                if (lsi > 0) {
                    canSeePlayer = false;
                    hasSetCanSeePlayer = true;
                }
                else {
                    canSeePlayer = true;
                }
            }
        }
    }
    for (var i = 0; i < count; i+= 6) {
        if (i == k) {
            continue;
        }
        var xx1 = eg[| i];
        var yy1 = eg[| i+1];
        var xx2 = eg[| i+2];
        var yy2 = eg[| i+3];
        var ppe = eg[| i+4];
        var nne = eg[| i+5];
        if (abs(xx2 - x1) <= thresh && abs(yy2 - y1) <= thresh) {
            pe = i;
        }
        else if (abs(xx1 - x2) <= thresh && abs(yy1 - y2) <= thresh) {
            ne = i;
        }
        if (pe != -1 && ne != -1) {
            break;
        }
    }
    eg[| k+4] = pe;
    eg[| k+5] = ne;
}
