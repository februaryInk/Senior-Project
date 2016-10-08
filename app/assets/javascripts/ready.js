$( document ).ready( function (  ) {
    
    $( '.js-tabs' ).tabs(  );
    
    setTimeout( function (  ) {
        
        $( '*[ autocomplete="off" ]' ).val( '' );
    }, 25 );
    
    if ( Cookies.get( 'time-zone' ) === undefined ) {
        var tz = jstz.determine(  );
        Cookies.set( 'time-zone', tz.name(  ), { expires: 1, path: '/' } );
    }
} );
