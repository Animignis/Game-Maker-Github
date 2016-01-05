var r = argument0;
var c = argument1;
var i = 0;

var q = ds_queue_create();
ds_queue_enqueue(q, c);
ds_queue_enqueue(q, r);

while(!ds_queue_empty(q)) {
    c = ds_queue_dequeue(q);
    r = ds_queue_dequeue(q);
    if (ds_grid_get(pgrid, c, r) == -1) {
        i += 1;
        var node;
        ds_list_add(fill, c);
        ds_list_add(fill, r);
        ds_grid_set(grid, c, r, 0);
        ds_grid_set(pgrid, c, r, 0);
        ds_queue_enqueue(q, 
            c + 1,  r, 
            c,      r - 1, 
            c - 1,  r, 
            c,      r + 1);
    }
}
ds_queue_destroy(q);
return i;
/*
if (ds_grid_get(grid, c, r) == -1) {
    ds_grid_set(grid, c, r, 0);
    
    var i = 1;
    i += CaveDeCheese(r, c + 1);
    i += CaveDeCheese(r, c - 1);
    i += CaveDeCheese(r + 1, c);
    i += CaveDeCheese(r - 1, c);
    
    var cr;
    cr[0] = c;
    cr[1] = r;
    ds_list_add(fill, cr);
    
    return i;
}
else {
    return 0;
}
*/