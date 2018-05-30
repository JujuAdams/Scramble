/// @param surface

var _surface = argument0;

var _surface_width  = ceil( surface_get_width(  _surface ) / __BLOCK_SIZE ) * __BLOCK_SIZE;
var _surface_height = ceil( surface_get_height( _surface ) / __BLOCK_SIZE ) * __BLOCK_SIZE;

var _output_surface = surface_create( _surface_width, _surface_height );
var _texture = surface_get_texture( global.__scramble_block_surface );

surface_set_target( _output_surface );
draw_clear_alpha( c_black, 0 );
surface_reset_target();

gpu_set_blendmode_ext( bm_one, bm_zero );
gpu_set_tex_filter( false );
for( var _y = 0; _y < _surface_height; _y += __BLOCK_SIZE ) {
    for( var _x = 0; _x < _surface_width; _x += __BLOCK_SIZE ) {
        
        surface_set_target( global.__scramble_work_surface );
        draw_surface( argument0, -_x, -_y );
        surface_reset_target();
        
        surface_set_target( _output_surface );
        shader_set( shScrambleUn );
        texture_set_stage( shader_get_sampler_index( shader_current(), "u_sMask" ), _texture );
        draw_surface( global.__scramble_work_surface, _x, _y );
        shader_reset();
        surface_reset_target();
        
    }
}
gpu_set_blendmode( bm_normal );
gpu_set_tex_filter( true );

return _output_surface;