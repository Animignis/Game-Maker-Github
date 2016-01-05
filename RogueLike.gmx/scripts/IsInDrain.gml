var r = argument0;
var c = argument1;
var s = ds_list_size(drain);

for (var i = 0; i < s; i += 2) {
    var cc = ds_list_find_value(drain, i);
    var rr = ds_list_find_value(drain, i + 1);
    if (cc == c && rr == r) {
        return i;
    }
}
return -1;
