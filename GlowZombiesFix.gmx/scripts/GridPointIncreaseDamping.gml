var index = argument0;
var factor = argument1;
var point = ds_map_find_value(points, index);
point[pd] *= factor;

ds_map_replace(points, index, point);
