source_surface = surface_create( sprite_get_width( sSource ), sprite_get_height( sSource ) );
gpu_set_blendenable( false );
surface_set_target( source_surface );
draw_clear_alpha( c_black, 0 );
draw_sprite( sSource, 0, 0, 0 );
surface_reset_target();
gpu_set_blendenable( true );

var _t = get_timer();
result_surface = scramble_sprite( sSource, 0 );
show_debug_message( "Scramble: Sprite processing took " + string( get_timer() - _t ) + "us" );

var _t = get_timer();
inverse_surface = scramble_un( result_surface );
show_debug_message( "Scramble: Unscramble took " + string( get_timer() - _t ) + "us" );