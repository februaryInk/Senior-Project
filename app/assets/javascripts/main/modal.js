$( document ).ready( function(  ) {
    
    // set up a jQuery-ui dialog for the feedback form.
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
    
    // bind to a link so that clicking it will open the dialog.
    $( '.link-add-modal' ).click( function(  ) {
        $( '#dialog' ).dialog( 'open' );
    } );
    
    // bind another link to close the dialog.
    $( '.close-dialog' ).click( function( el ) {
        el.preventDefault(  );
        $( '#dialog' ).dialog( 'close' );
    } );
} );
