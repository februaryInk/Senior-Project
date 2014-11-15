$( document ).ready( function(  ) {
    var activeLink = $( '#header-tabs a[ href="' + window.location.pathname + '" ]' );
    $( activeLink ).addClass( 'active' );

    
    $( '.dropdown' ).mouseover( openSubMenu );
    $( '.dropdown' ).mouseout( closeSubMenu );
    
    function openSubMenu(  ) {
        $( this ).find( 'ul' ).css( 'visibility', 'visible' );
    };
    
    function closeSubMenu(  ) {
        $( this ).find( 'ul' ).css( 'visibility', 'hidden' );
    };
});