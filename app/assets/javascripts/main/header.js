$( document ).ready( function(  ) {
    
    // detect the open "tab" on the header with tabs and style it a certain way.
    var activeLink = $( '#header-tabs a[ href="' + window.location.pathname + '" ]' );
    $( activeLink ).addClass( 'active' );

    // make a dropdown menu operable.
    $( '.dropdown' ).mouseover( openSubMenu );
    $( '.dropdown' ).mouseout( closeSubMenu );
    
    // make dropdown visible.
    function openSubMenu(  ) {
        $( this ).find( 'ul' ).css( 'visibility', 'visible' );
    };
    
    // make dropdown hidden.
    function closeSubMenu(  ) {
        $( this ).find( 'ul' ).css( 'visibility', 'hidden' );
    };
} );