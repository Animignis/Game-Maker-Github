var index = argument0;
var fx = argument1;
var fy = argument2;
var point = ds_map_find_value(points, index);
point[pax] += fx * point[pim];
point[pay] += fy * point[pim];

ds_map_replace(points, index, point);
