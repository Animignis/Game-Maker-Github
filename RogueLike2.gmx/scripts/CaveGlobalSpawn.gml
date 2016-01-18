/// CaveGlobalSpawn(instance)
with(obj_cave) {
    var rand = floor(random(ds_list_size(empty) / 2)) * 2;
    var xx = empty[| rand] * CELL_SIZE + CELL_SIZE / 2;
    var yy = empty[| rand+1] * CELL_SIZE + CELL_SIZE / 2;
    instance_create(xx, yy, argument0);
}
