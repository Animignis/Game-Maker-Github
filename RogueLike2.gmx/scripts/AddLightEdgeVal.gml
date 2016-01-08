var cs = CELL_SIZE;
var val = argument0;
var xx = argument1;
var yy = argument2;
if (val >= 1 && val <= 4) {
    switch(val) {
        case 1:
        AddLightEdge(
            xx, yy + cs,
            xx + cs, yy);
        break;
        
        case 2:
        AddLightEdge(
            xx + cs, yy + cs,
            xx, yy);
        break;
        
        case 3:
        AddLightEdge(
            xx + cs, yy,
            xx, yy + cs);
        break;
        
        case 4:
        AddLightEdge(
            xx, yy,
            xx + cs, yy + cs);
        break;
    }
}
else {
    switch(val) {
        case 5:
        AddLightEdge(
            xx + cs, yy + cs,
            xx + cs, yy);
        break;
        
        case 6:
        AddLightEdge(
            xx + cs, yy,
            xx, yy);
        break;
        
        case 7:
        AddLightEdge(
            xx, yy,
            xx, yy + cs);
        break;
        
        case 8:
        AddLightEdge(
            xx, yy + cs,
            xx + cs, yy + cs);
        break;
    }
}
