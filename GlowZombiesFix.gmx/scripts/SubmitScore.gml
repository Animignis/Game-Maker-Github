/**
    SubmitScore(name, score): submit a new highscore entry online
*/

var obj;
obj = instance_create(0, 0, obj_submit_score_helper);
obj.name = argument0;
obj._score = argument1;
show_debug_message(string(argument0) + ": " + string(argument1));
return obj;