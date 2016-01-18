CheckWin();

TrailStep(mouse_x, mouse_y);

ViewControl();

var b = CELL_SIZE * 2;
instance_activate_all();
instance_deactivate_region(
    view_xview - b,
    view_yview - b,
    view_wview + 2 * b,
    view_hview + 2 * b,
    false, true);
for (var i = 0; i < ds_list_size(activeObjs); i++) {
    instance_activate_object(ds_list_find_value(activeObjs, i));
}

time += 1;
