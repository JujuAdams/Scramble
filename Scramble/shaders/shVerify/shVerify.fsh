varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D u_sOther;

void main() {
    
    gl_FragColor = mix( vec4( 0.4, 0.9, 0.2, 1. ), vec4( 1., 0.2, 0.2, 1. ), distance( texture2D( gm_BaseTexture, v_vTexcoord ), texture2D( u_sOther, v_vTexcoord ) ) );
    
}
