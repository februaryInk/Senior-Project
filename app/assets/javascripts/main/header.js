$( document ).ready( function(  ) {
    
    var path = window.location.pathname;
    
    // style the appropriate links.
    openLink( path );    
    openCategoricalLink( path );

    // make dropdown menus operable.
    $( '.js-dropdown' ).mouseover( openSubMenu );
    $( '.js-dropdown' ).mouseout( closeSubMenu );
} );

// make dropdown visible.
function openSubMenu(  ) {
    
    $( this ).find( 'ul' ).css( 'visibility', 'visible' );
}

// make dropdown hidden.
function closeSubMenu(  ) {
    
    $( this ).find( 'ul' ).css( 'visibility', 'hidden' );
}

// detect and style the single most appropriate "categorical link" - a link 
// that should be open for sub-pages in addition to its main page.
function openCategoricalLink( path ) {
    
    var $openCategoricalLink = null;
    var hrefPieces;
    var i;
    var matches;
    var pathPieces = path.split( '/' );
    var prevLength = 0;
    var prevMatches = 0;
    
    $( '.js-openable-categorical-link' ).each( function( index, element ) {
        hrefPieces = $( element ).attr( 'href' ).split( '/' );
        matches = 0;
        
        for ( i = 0; i < hrefPieces.length; i++ ) {
            if ( pathPieces.indexOf( hrefPieces[ i ] ) != -1 ) {
                matches++;
            }
        }
        
        // if more pieces of this link's href match than the last, or if the 
        // same number of pieces match, but the pieces for matching are fewer, 
        // then...
        if ( matches > prevMatches || ( matches == prevMatches && matches > 0 && hrefPieces.length < prevLength ) ) {
            prevMatches = matches;
            prevLength = hrefPieces.length;
            $openCategoricalLink = $( element );
        }
    } );
    
    if ( $openCategoricalLink ) {
        $openCategoricalLink.addClass( '-open' );
    }
}

// detect the open "tab" on the header with tabs and style it a certain way.
function openLink( path ) {
    var $openLink = $( 'a[ href="' + path + '" ].js-openable-link' );
    $openLink.addClass( '-open' );
}
