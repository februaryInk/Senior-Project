$( document ).ready( function(  ) {
    
    // detect the open "tab" on the header with tabs and style it a certain way.
    var activeLink = $( 'a[ href="' + window.location.pathname + '" ].js-openable-link' );
    $( activeLink ).addClass( 'open' );

    // make a dropdown menu operable.
    $( '.dropdown' ).mouseover( openSubMenu );
    $( '.dropdown' ).mouseout( closeSubMenu );
} );

// make dropdown visible.
function openSubMenu(  ) {
    $( this ).find( 'ul' ).css( 'visibility', 'visible' );
};

// make dropdown hidden.
function closeSubMenu(  ) {
    $( this ).find( 'ul' ).css( 'visibility', 'hidden' );
};
