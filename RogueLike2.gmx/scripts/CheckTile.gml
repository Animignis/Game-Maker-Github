var xx = argument0;
var yy = argument1;
var c = floor(xx / CELL_SIZE);
var r = floor(yy / CELL_SIZE);
var ret = false;
var xm = xx mod CELL_SIZE;
var ym = yy mod CELL_SIZE;
with(obj_cave) {
    var i = ds_grid_get(grid, c, r);
    switch(i) {
        case -1:
        ret = false;
        break;
        
        case 1:
        ret = !(ym > (CELL_SIZE - xm));
        break;
        
        case 2:
        ret = !(ym < xm);
        break;
        
        case 3:
        ret = !(ym < (CELL_SIZE - xm));
        break;
        
        case 4:
        ret = !(ym > xm);
        break;
        
        default:
        ret = true;
        break;
    }
}
return ret;
