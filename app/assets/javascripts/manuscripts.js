$( document ).ready( function (  ) {
    
    // make manuscript contents sortable with jQuery-ui's sortable interface. 
    // affected sections update after a sort and ajax reloads the contents table.
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
        $( this ).parent(  ).submit(  );
    } );
    
    // AJAX update the section being displayed when a new value is selected from 
    // the drop-down list with id selector-for-links.
    $( '#js-selector-for-writer' ).change( function( el ) {
        var section_num = $( this ).val(  );
        $.ajax( {
            url : 'sections/select_for_writer',
            type : 'GET',
            data : { data_value: section_num }
        } );
    } );
    
    // AJAX update the section being displayed when a new value is selected from 
    // the drop-down list with id selector-for-reader.
    $( '#js-selector-for-reader' ).change( function( el ) {
        var section_num = $( this ).val(  );
        $.ajax( {
            url : 'sections/select_for_reader',
            type : 'GET',
            data : { data_value: section_num }
        } );
    } );
    
    // submit the section update form from the header.
    $( '.button-submit-section' ).click( function( evt ) {
        $( '#form-section-update' ).submit(  );
    } );
    
    // submit the section update and publish form from the header. set the publish
    // param to true.
    $( '.button-submit-and-publish-section' ).click( function( evt ) {
        var input = $( '<input>' ).attr( 'type', 'hidden' ).attr( 'name', 'publish' ).val( true );
        $( '#form-section-update' ).append( $( input ) );
        $( '#form-section-update' ).submit(  );
    } );
} );

$( document ).on( 'click', '.leave-feedback', function( evt ) {
    evt.preventDefault(  );
    var manuscriptId = $( this ).attr( 'id' );
    modalDialog( 'Feedback', 'Leave your feedback for this manuscript.', { content: 'textarea' }, 
    function( inputs, values, modal ) {
        $.ajax( {
            url: '/manuscripts/' + manuscriptId + '/feedback',
            type: 'post',
            dataType: 'json',
            data: {
                feedback: {
                    content: values.content
                }
            },
            success: function(  ) {
                modal.dialog( 'close' ).remove(  );
                window.location.reload(  );
            },
            error: function( response ) {
                // derive form validation errors from the response, then rebuild the form with 
                // its errors marked.
                var errors = JSON.parse( response.responseText );
                var formHtml = buildForm( inputs, errors );
                $( 'dialog-form' ).html( formHtml );
            }
        } );
    } );
} );