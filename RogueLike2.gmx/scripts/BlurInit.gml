/// BlurInit(length, sprite, blend, alpha, decAlpha, x, y, rot)
len = argument0;
spr = argument1;
blend = argument2;
alpha = argument3;
decAlpha = argument4;

xx[len - 1] = argument5;
yy[len - 1] = argument6;
ind = 0;

var i;
for (i = 0; i < len; i++) {
    xx[i] = argument5;
    yy[i] = argument6;
}

da = (alpha / len);

imgNum = 0;
imgInd = 0;
imgMax = sprite_get_number(spr);
log(string(imgMax));

blurRot = argument7;
