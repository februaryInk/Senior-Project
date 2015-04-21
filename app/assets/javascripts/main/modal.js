$( document ).ready( function(  ) {
    
    $( '#dialog' ).dialog( {
        autoOpen: false,
        height: 600,
        modal: true,
        open: function( event, ui ) {
            $( this ).load( '/feedback/new' );
        },
        resizable: false,
        width: 500
    } );
    
    $( '.link-add-modal' ).click( function(  ) {
        $( '#dialog' ).dialog( 'open' );
    } );
    
    $( '.close-dialog' ).click( function( el ) {
        el.preventDefault(  );
        $( '#dialog' ).dialog( 'close' );
    } );
} );
