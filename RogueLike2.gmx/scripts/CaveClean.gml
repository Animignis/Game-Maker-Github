if (ds_exists(grid, ds_type_grid)) {
    ds_grid_destroy(grid);
}
if (ds_exists(eg, ds_type_list)) {
    ds_list_destroy(eg);    
}
if (ds_exists(egp, ds_type_priority)) {
    ds_list_destroy(egp);    
}
if (surface_exists(surf)) {
    surface_free(surf);
}
if (ds_exists(empty, ds_type_list)) {
    ds_list_destroy(empty);
}
