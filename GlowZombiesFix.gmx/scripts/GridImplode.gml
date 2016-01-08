var xx = argument0;
var yy = argument1;
var force = argument2;
var radius = argument3;
var i;
for (i = 0; i < grid_w * grid_h; i++)
{
    var point = ds_map_find_value(points, i);
    var pointDistSquared = power(point[px] - xx, 2) + power(point[py] - yy, 2);
    var dist2 = pointDistSquared;
    if (dist2 < radius * radius)
    {
        var fx = 100 * force * (xx - point[px]) / (10000 + dist2);
        var fy = 100 * force * (yy - point[py]) / (10000 + dist2);
        GridPointApplyForce(i, fx, fy);
        GridPointIncreaseDamping(i, 0.3);
    }
}
