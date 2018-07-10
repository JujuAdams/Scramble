varying vec2 v_vTexcoord;

uniform sampler2D u_sMask;

void main()
{
    gl_FragColor = texture2D( gm_BaseTexture, texture2D( u_sMask, v_vTexcoord ).ba );
}
