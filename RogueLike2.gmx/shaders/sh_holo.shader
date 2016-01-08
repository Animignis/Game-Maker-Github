//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float vTime;
uniform float vIsWobbling;

void main()
{
    vec4 obj_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    //gl_Position = gm_Matrices[MATRIX_PROJECTION] * gm_Matrices[MATRIX_VIEW] * gm_Matrices[MATRIX_WORLD] * obj_space_pos;
    gl_Position = 
        gm_Matrices[MATRIX_PROJECTION] * gm_Matrices[MATRIX_VIEW] * obj_space_pos;
    float speed = 15.0;
    float freq = 40.0;
    float amp = 0.0133;
    gl_Position.x = 
        gl_Position.x
        +(cos(obj_space_pos.y*freq + vTime*speed)*amp)*vIsWobbling;
    gl_Position.y = 
        gl_Position.y
        +(sin(obj_space_pos.x*freq + vTime*speed)*amp)*vIsWobbling;
    //gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float time;
//uniform vec2 view;

highp float rand(vec2 co)
{
    highp float a = 12.9898;
    highp float b = 78.233;
    highp float c = 43758.5453;
    highp float dt= dot(co.xy ,vec2(a,b));
    highp float sn= mod(dt,3.14);
    return fract(sin(sn) * c);
}

void main()
{

    float div = 1.0;
    vec2 texCoord = v_vTexcoord;
    //texCoord.x = texCoord.x+cos(texCoord.y+time*0.1)*0.1; 
    //texCoord.y = texCoord.y+sin(texCoord.x+time*0.1)*0.1;
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, texCoord);
    float rn = rand(vec2(texCoord.x / div, (texCoord.y / div) + time));
    
    vec2 pos = v_vTexcoord;
    //pos += view;
    float dist = sqrt(pow((pos.x-0.5)*2.0, 2.0) + pow((pos.y-0.5)*2.0, 2.0)) / sqrt(2.0);
    dist = 1.0 - dist;    
    dist = pow(dist * 3.0, 3.0) / 27.0;
    dist = clamp(dist, 0.0, 1.0);
    
    gl_FragColor.g *= rn;
    gl_FragColor.r = dist;
}

