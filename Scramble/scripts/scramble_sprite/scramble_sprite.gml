/// @param sprite
/// @param image

var _sprite = argument0;
var _image  = argument1;

var _surface_width  = ceil( sprite_get_width(  _sprite ) / __BLOCK_SIZE ) * __BLOCK_SIZE;
var _surface_height = ceil( sprite_get_height( _sprite ) / __BLOCK_SIZE ) * __BLOCK_SIZE;

var _output_surface = surface_create( _surface_width, _surface_height );
var _texture = surface_get_texture( global.__scramble_block_surface );

surface_set_target( _output_surface );
draw_clear_alpha( c_black, 0 );
surface_reset_target();

gpu_set_blendenable( false );
gpu_set_tex_filter( false );
for( var _y = 0; _y < _surface_height; _y += __BLOCK_SIZE ) {
    for( var _x = 0; _x < _surface_width; _x += __BLOCK_SIZE ) {
        
        surface_set_target( global.__scramble_work_surface );
        draw_clear_alpha( c_black, 0 );
        draw_sprite( _sprite, _image, -_x, -_y );
        surface_reset_target();
        
        surface_set_target( _output_surface );
        shader_set( shScramble );
        texture_set_stage( shader_get_sampler_index( shader_current(), "u_sMask" ), _texture );
        draw_surface( global.__scramble_work_surface, _x, _y );
        shader_reset();
        surface_reset_target();
        
    }
}
gpu_set_blendenable( true );
gpu_set_tex_filter( true );

return _output_surface;