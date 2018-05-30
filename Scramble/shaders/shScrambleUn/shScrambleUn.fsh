varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D u_sMask;

void main() {
    
    gl_FragColor = texture2D( gm_BaseTexture, texture2D( u_sMask, v_vTexcoord ).ba );
    
}
