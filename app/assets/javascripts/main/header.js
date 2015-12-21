$( document ).ready( function(  ) {
    
    // detect the open "tab" on the header with tabs and style it a certain way.
    var openLink = $( 'a[ href="' + window.location.pathname + '" ].js-openable-link' );
    $( openLink ).addClass( 'open' );

    // make a dropdown menu operable.
    $( '.js-dropdown' ).mouseover( openSubMenu );
    $( '.js-dropdown' ).mouseout( closeSubMenu );
} );

// make dropdown visible.
function openSubMenu(  ) {
    $( this ).find( 'ul' ).css( 'visibility', 'visible' );
};

// make dropdown hidden.
function closeSubMenu(  ) {
    $( this ).find( 'ul' ).css( 'visibility', 'hidden' );
};
