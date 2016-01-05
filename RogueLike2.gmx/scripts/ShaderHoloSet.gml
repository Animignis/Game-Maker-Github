var wob = 0;

if (wobTimer > 0) {
    wob = 1;
}

shader_set(sh_holo);
var vTimeHandle = shader_get_uniform(sh_holo, "vTime");
var vWobbleHandle = shader_get_uniform(sh_holo, "vIsWobbling");
var timeHandle = shader_get_uniform(sh_holo, "time");
shader_set_uniform_f(vTimeHandle, time);
shader_set_uniform_f(vWobbleHandle, wob);

shader_set_uniform_f(timeHandle, holoTime);