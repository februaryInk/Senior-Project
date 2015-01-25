$( document ).ready( function (  ) {
    $( 'tbody.sortable' ).sortable( {
        stop: function( e, ui ) {
            var positions = $.map( $( this ).find( 'tr' ), function( el ) {
                return $( el ).attr( 'id' );
            } );
            $.ajax( {
                url : 'sections/sort',
                type : 'PATCH',
                data : { data_value: JSON.stringify( positions ) }
            } );
        }
    } );
    
    $( 'body' ).on( 'blur', '.auto-submit', function(  ) {
        $( this ).parent(  ).submit(  )
    } );
    
    $( '#selector-for-links' ).change( function( e ) {
        var section_num = $( this ).val(  );
        $.ajax( {
            url : 'sections/select',
            type : 'GET',
            data : { data_value: section_num }
        } );
    } );
} );