/// @param sprite
/// @param image

var _surface = argument0;

//Set the output surface's size such that it is an integer number of block wide and high (rounded up)
var _surface_width  = ceil( surface_get_width(  _surface ) / __SCRAMBLE_BLOCK_SIZE ) * __SCRAMBLE_BLOCK_SIZE;
var _surface_height = ceil( surface_get_height( _surface ) / __SCRAMBLE_BLOCK_SIZE ) * __SCRAMBLE_BLOCK_SIZE;

var _output_surface = surface_create( _surface_width, _surface_height );
var _texture = surface_get_texture( global.__scramble_block_surface );

surface_set_target( _output_surface );
	draw_clear_alpha( c_black, 0 );
surface_reset_target();

//Turn off alpha blending and turn off interpolation
var _old_blendenable = gpu_get_blendenable();
var _old_tex_filter  = gpu_get_tex_filter();
gpu_set_blendenable( false );
gpu_set_tex_filter( false );

//Iterate over each block that comprises the output surface
for( var _y = 0; _y < _surface_height; _y += __SCRAMBLE_BLOCK_SIZE )
{
    for( var _x = 0; _x < _surface_width; _x += __SCRAMBLE_BLOCK_SIZE )
	{
		//Clear out the work surface, and draw part of our input image onto it
        surface_set_target( global.__scramble_work_surface );
	        draw_clear_alpha( c_black, 0 );
	        draw_surface( _surface, -_x, -_y );
        surface_reset_target();
        
		//Draw block to the output surface, but through the scramble shader
        surface_set_target( _output_surface );
        shader_set( shScramble );
	        texture_set_stage( shader_get_sampler_index( shader_current(), "u_sMask" ), _texture );
	        draw_surface( global.__scramble_work_surface, _x, _y );
	        shader_reset();
        surface_reset_target();
    }
}

//Restore previous settings
gpu_set_blendenable( _old_blendenable );
gpu_set_tex_filter( _old_tex_filter );

return _output_surface;