( function( $ ) {
    
    $.fn.tabs = function (  ) {
        
        console.log( $( this ).length );

        $( this ).each( function( i, element ) {
          
            if ( !$( this ).hasClass( 'activated' ) ) {
              
                $( this ).addClass( 'activated' );
        
                var tabs = $( this ).children( '*[ data-target-id ]' );
                var tabContentIds = $( tabs ).map( function(  ) { return( '#' + $( this ).data( 'target-id' ) ); } ).get(  ).join( ', ' );
                var tabContents = $( tabContentIds );
                
                $( tabs ).each( function( j, tab ) {
                    $( document ).on( 'click', '*[ data-target-id="' + $( tab ).data( 'target-id' ) + '" ]', function( event ) {
                        var tabContentId = '#' + $( this ).data( 'target-id' );
                        var tabContent = $( tabContentId );
                        
                        $( tabs ).removeClass( '-open' );
                        $( this ).addClass( '-open' );
                        
                        $( tabContents ).removeClass( '-open' );
                        $( tabContent ).addClass( '-open' );
                    } );
                } );
            }
        } );
    }
} )( jQuery );
