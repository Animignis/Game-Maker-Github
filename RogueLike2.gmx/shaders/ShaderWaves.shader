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
precision mediump float;
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float time;

float wave(vec2 pos, float angle) {
  vec2 direction = vec2(cos(angle), sin(angle));
  return cos(dot(pos, direction));
}

float wrap(float x) {
  return abs(mod(x, 2.)-1.);
}

void main() {
  vec2 pos = (v_vTexcoord - 0.5) * 50.;

  float brightness = 0.0;
  for (float i = 1.0; i <= 11.0; i++) {
    brightness += wave(pos, time / i);
  }

  brightness = wrap(brightness);

  gl_FragColor = v_vColour * brightness;
}

