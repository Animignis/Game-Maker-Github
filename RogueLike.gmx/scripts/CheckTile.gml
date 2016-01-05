var xx = argument0;
var yy = argument1;
var c = floor(xx / CELL_SIZE);
var r = floor(yy / CELL_SIZE);
var a = false;
var xm = xx mod 32;
var ym = yy mod 32;
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
        a = !(ym > (32 - xm));
        break;
        
        case 2:
        a = !(ym < xm);
        break;
        
        case 3:
        a = !(ym < (32 - xm));
        break;
        
        case 4:
        a = !(ym > xm);
        break;
    }
}
return a;