log("particle cleanup");

part_system_destroy(ps);

var size = ds_list_size(plist);
for (var i = 0; i < size; i++) {
    part_type_destroy(plist[| i]);
}
