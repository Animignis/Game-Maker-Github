gridSurf = surface_create(1024, 1024);

area_w = 1024;
area_h = 1024;

grid_w = 16;
grid_h = 16;
var w = grid_w;
var h = grid_h;
damp = 0.9;
var invMass = 1;
numCells = w * h;
grid = ds_grid_create(w, h);
points = ds_map_create();
lines = ds_list_create();
s = area_w / grid_w; //size of each grid space

px = 0; // x
py = 1; // y
pvx = 2; // velocity x
pvy = 3; // velocity y
pax = 4; // accel x
pay = 5; // accel y
pd = 6; // damping
pim = 7; // inverse mass

lp1 = 0; // point 1
lp2 = 1; // point 2
ltlx = 2; // target length
ltly = 3
lstf = 4; // stiffness
ld = 5; // damping

xoff = s * 0.5;
yoff = s * 0.5;

var fixedPoints = ds_map_create();

var xx, yy, i;
i = 0;
for (yy = 0; yy < h; yy++) {
    for (xx = 0; xx < w; xx++) {
        ds_grid_set(grid, xx, yy, i);
        var point;
        point[7] = invMass; // inverse mass
        if (xx == 0 || yy == 0 || xx == w - 1 || yy == h - 1) {
            point[7] = 0;
        }
        point[0] = xx * s + xoff;  // x position of node
        point[1] = yy * s + yoff;  // y position of node
        point[2] = 0;       // x velocity
        point[3] = 0;       // y velocity
        point[4] = 0;       // x accel
        point[5] = 0;       // y accel
        point[6] = damp;    // damping factor
        ds_map_add(points, i, point);
        point[7] = 0;
        ds_map_add(points, i + numCells, point);
        i++;
    }
}

i = 0;
for (yy = 0; yy < h; yy++) {
    for (xx = 0; xx < w; xx++) {
        var line;
        line[5] = 0.01;
        line[0] = i + numCells;
        line[1] = i;
        line[2] = 0;
        line[3] = 0;
        line[4] = 0.25;
        ds_list_add(lines, line);
        /*
        if (xx == 0 || yy == 0
                || xx == w - 1 || yy == h - 1) {
            line[0] = i + numCells;
            line[1] = i;
            line[2] = 0;
            line[3] = 0;
            line[4] = 0.1; // 1
            line[5] = 0.1;
            ds_list_add(lines, line);
        }
        else if (xx mod 2 == 0 && yy mod 2 == 0) {
            line[0] = i + numCells;
            line[1] = i;
            line[2] = 0;
            line[3] = 0
            line[4] = 0.002; // 1
            line[5] = 0.02; // 0.05
            ds_list_add(lines, line);
        }
        */
        if (xx > 0) {
            line[0] = i - 1;
            line[1] = i;
            line[2] = s;
            line[3] = 0;
            //line[4] = 0.3; // 1
            //line[5] = 0.05;
            ds_list_add(lines, line);
        }
        if (yy > 0) {
            line[0] = i - w;
            line[1] = i;
            line[2] = 0;
            line[3] = s;
            //line[4] = 0.2; // 1
            //line[5] = 0.01;
            ds_list_add(lines, line);
        }
        
        i++;
    }
}
