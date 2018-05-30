gml_pragma( "global", "__scramble_init()" );

var _t = get_timer();

global.__scramble_work_surface = surface_create( __BLOCK_SIZE, __BLOCK_SIZE );

global.__scramble_block_surface = surface_create( __BLOCK_SIZE, __BLOCK_SIZE );
var _buffer = buffer_create( __BLOCK_BYTES, buffer_u8, 1 );

var _list = ds_list_create();
for( var _i = 0; _i < __BLOCK_PIXELS; _i++ ) ds_list_add( _list, _i );

if ( SCRAMBLE_SEED != undefined ) {
    var _old_seed = random_get_seed();
    random_set_seed( SCRAMBLE_SEED );
    ds_list_shuffle( _list );
    random_set_seed( _old_seed );
} else {
    ds_list_shuffle( _list );
}

for( var _i = 0; _i < __BLOCK_PIXELS; _i++ ) {
    var _v = _list[| _i ];
    buffer_poke( _buffer, _i*4  , buffer_u16, _v ); //Embed scramble position in the RG channels
    buffer_poke( _buffer, _v*4+2, buffer_u16, _i ); //Embed inverse scramble position in the BA channels
}

buffer_set_surface( _buffer, global.__scramble_block_surface, 0, 0, 0 );
ds_list_destroy( _list );

show_debug_message( "Scramble: Initialisation took " + string( get_timer() - _t ) + "us, seed=" + string( SCRAMBLE_SEED ) );