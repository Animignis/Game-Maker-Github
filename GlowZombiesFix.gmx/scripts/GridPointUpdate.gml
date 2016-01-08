var index = argument0;
var point = ds_map_find_value(points, index);

point[pvx] += point[pax];
point[pvy] += point[pay];

point[px] += point[pvx];
point[py] += point[pvy];

point[pax] = 0;
point[pay] = 0;

var vMagSquared = power(point[pvx], 2) + power(point[pvy], 2);

if (vMagSquared < 0.1 * 0.1) {
    point[pvx] = 0;
    point[pvy] = 0;
}

point[pvx] *= point[pd];
point[pvy] *= point[pd];

point[pd] = damp;

ds_map_replace(points, index, point);
