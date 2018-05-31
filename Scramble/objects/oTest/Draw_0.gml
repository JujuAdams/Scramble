var _text = "Press any key to show source->unscrambled surface comparison";

if ( keyboard_check( vk_anykey ) ) {
    
    gpu_set_tex_filter( false );
    shader_set( shVerify );
    texture_set_stage( shader_get_sampler_index( shader_current(), "u_sOther" ), surface_get_texture( inverse_surface ) );
    draw_surface( source_surface, 0, 0 );
    shader_reset();
    gpu_set_tex_filter( true );
    
} else {
    
    draw_surface_part( inverse_surface,   0,       0,   mouse_x             , room_height,         0, 0 );
    draw_surface_part(  result_surface,   mouse_x, 0,   room_width - mouse_x, room_height,   mouse_x, 0 );
    
}

draw_set_colour( c_black );
draw_text( 10,  8, _text );
draw_text( 10, 12, _text );
draw_text(  8, 10, _text );
draw_text( 12, 10, _text );
draw_set_colour( make_colour_hsv( ( current_time/5 mod 255 ), 80, 255 ) );
draw_text( 10, 10, _text );