gml_pragma( "global", "__scramble_init()" );

var _t = get_timer();

//Create a surface, the size of a block, to use for processing later
global.__scramble_work_surface = surface_create( __SCRAMBLE_BLOCK_SIZE, __SCRAMBLE_BLOCK_SIZE );

//Create a surface that will contain our scramble key
//Both forward and reverse operations are encoded, in the RG and BA channels respectively
global.__scramble_block_surface = surface_create( __SCRAMBLE_BLOCK_SIZE, __SCRAMBLE_BLOCK_SIZE );
var _buffer = buffer_create( __SCRAMBLE_BLOCK_BYTES, buffer_u8, 1 );

//Create a lookup table that contains every possible pixel in a block (which is 256x256)
var _list = ds_list_create();
for( var _i = 0; _i < __SCRAMBLE_BLOCK_PIXELS; _i++ ) ds_list_add( _list, _i );

if ( SCRAMBLE_SEED != undefined )
{
	//If the dev has specified a seed, use that to generate the key surface
    var _old_seed = random_get_seed();
    random_set_seed( SCRAMBLE_SEED );
    ds_list_shuffle( _list );
    random_set_seed( _old_seed );
}
else
{
	//Otherwise use whatever seed is available
    ds_list_shuffle( _list );
}

for( var _i = 0; _i < __SCRAMBLE_BLOCK_PIXELS; _i++ ) {
    var _v = _list[| _i ];
    buffer_poke( _buffer, _i*4  , buffer_u16, _v ); //Embed scramble position in the RG channels
    buffer_poke( _buffer, _v*4+2, buffer_u16, _i ); //Embed inverse scramble position in the BA channels
}

//Convert the buffer into a surface for use in our shader
buffer_set_surface( _buffer, global.__scramble_block_surface, 0, 0, 0 );

//Clean up the pixel lookup table
ds_list_destroy( _list );

show_debug_message( "Scramble: Initialisation took " + string( get_timer() - _t ) + "us, seed=" + string( SCRAMBLE_SEED ) );