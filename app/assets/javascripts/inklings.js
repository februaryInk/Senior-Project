$( document ).ready( function(  ) {

    var inklingContainers = $( '.div-inkling-container' )
    
    for ( var i = 0; i < inklingContainers.length; i++ ) {
        var selectors = $( inklingContainers[ i ] ).data( 'selectors' )
        var inkling = $( inklingContainers[ i ] ).children(  ).first(  )
        
        $( inkling ).find( '.leg-main' ).children(  ).css( 'visibility', 'visible' );
    
        for ( var i = 0; i < selectors.length; i++ ) {
            $( inkling ).find( '.' + selectors[ i ] ).children(  ).css( 'visibility', 'visible' );  
        }            
    }
} );