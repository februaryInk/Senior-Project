$( document ).ready( function(  ) {
    var index = window.location.pathname.split( '/' )[ 2 ];
    $( 'li.' + index ).addClass( 'active' );
});