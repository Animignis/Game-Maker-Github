var c = argument0;
var r = argument1;
var a = false;
var cs = CELL_SIZE;
var xx = c * cs;
var yy = r * cs;
var xm = xx mod CELL_SIZE;
var ym = yy mod CELL_SIZE;
with(obj_cave) {
    var i = ds_grid_get(grid, c, r);
    switch(i) {
        case -1:
        a = false;
        break;
        
        default:
        a = true;
        break;
        
        case 1:
        a = !(ym > (CELL_SIZE - xm));
        break;
        
        case 2:
        a = !(ym < xm);
        break;
        
        case 3:
        a = !(ym < (CELL_SIZE - xm));
        break;
        
        case 4:
        a = !(ym > xm);
        break;
    }
}
return a;