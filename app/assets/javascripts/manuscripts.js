$( document ).ready( function (  ) {
    
    // make manuscript contents sortable with jQuery-ui's sortable 
    // interface. affected sections update after a sort and ajax
    // reloads the contents table.
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
    
    // submit form on blur of elements with class auto-submit.
    $( 'body' ).on( 'blur', '.auto-submit', function(  ) {
        $( this ).parent(  ).submit(  )
    } );
    
    // ajax update the section being displayed when a new value is 
    // selected from the drop-down list with id selector-for-links.
    $( '#selector-for-links' ).change( function( el ) {
        var section_num = $( this ).val(  );
        $.ajax( {
            url : 'sections/select',
            type : 'GET',
            data : { data_value: section_num }
        } );
    } );
    
    $( '#selector-for-reader' ).change( function( el ) {
        var section_num = $( this ).val(  );
        $.ajax( {
            url : 'sections/select_for_reader',
            type : 'GET',
            data : { data_value: section_num }
        } );
    } );
    
    $( '.feedback-popup' ).click( function( el ) {
        el.preventDefault(  );
        var popup = window.open( '/feedback/new', '_blank' );
        return( false );
    } );
} );