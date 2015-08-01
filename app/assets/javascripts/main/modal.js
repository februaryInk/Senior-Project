function modalDialog( title, message, inputs, callback ) {
        
    var html = '';
    
    // the enclosing div elements are perplexingly important. without them, the
    // dialog divides into two dialogs: one containing the paragraph, and one
    // containing the form.
    html += '<div>' +
                '<p>' + 
                    message + 
                '</p>' +
                '<div id="dialog-form-container">' +
                    buildForm( inputs ) +
                '</div>' +
            '</div>';
    
    $( html ).appendTo( 'body' ).dialog( {
        modal: true,
        dialogClass: 'inkling_dialog',
        buttons: {
            Submit: function(  ) {
                callback( inputs, $( '#dialog-form' ).serializeObject(  ), $( this ) );
            },
            Cancel: function(  ) {
                $( this ).dialog( 'close' ).remove(  );
            }
        }
    } );
}

function buildForm( inputs, errors ) {
    
    var errorsListHtml = '';
    var formHtml = '';
    var element, options, type, wrapper;
    var thisInputErrors = null;
    var klass = '';
    
    if ( errors ) {
        errorsListHtml += '<div class="errors"><ul>';
        
        for ( inputWithErrors in errors ) {
            
            messages = errors[ inputWithErrors ];
            
            for ( var i = 0; i < messages.length; i++ ) {
                errorsListHtml += '<li>' + messages[ i ] + '</li>';
            }
        }
        
        errorsListHtml += '</ul></div>';
    }
    
    formHtml += errorsListHtml +
                '<form id="dialog-form"><ul>';
    
    for ( name in inputs ) {
        
        type = inputs[ name ];
        
        if ( /^(datepicker|checkbox|text)$/.test( type ) ) {
            wrapper = 'input';
        }
        else if ( type === 'textarea' ) {
            wrapper = 'textarea';
        }
        else if ( $.isArray( type ) ) {
            element = 'option';
            options = type;
            type = '';
            wrapper = 'select';
        }
        else {
            throw new Error( 'Unsupported input type: {' + name + ': ' + type + ' }' );
        }
        
        if ( errors ) {
            thisInputErrors = eval( 'errors[ ' + name + ' ]' );
        }
        
        if ( type === 'datepicker' ) {
            klass = type;
        }
        
        thisInputHtml = '<li>' +
                            '<label>' + 
                                name.replace( '_', ' ') + 
                            '</label>' +
                        '</li>' +
                        '<li>' +
                            '<' + wrapper + ' name="' + name + '" class="' + klass + ' ' + (thisInputErrors ? 'field-error' : '') + '" type="' + type + '">' +
                                ( function(  ) {
                                    if ( options ) {
                                        var results = [];
                                        for ( var i = 0; i <= options.length; i++ ) {
                                            var value = options[ i ]
                                            var $element = $( '<' + element + '/>' );
                                            if ( $.isArray( value ) ) {
                                                $element.text( value[ 0 ] ).val( value[ 1 ] );
                                            }
                                            else {
                                                $element.text( value );
                                            }
                                            results.push( $element.wrap( '<div>' ).parent(  ).html(  ) );
                                        }
                                        return( results.join( '' ) );
                                    }
                                    else {
                                        return( '' );
                                    }
                                } )(  ) +
                            '</' + wrapper + '>' +
                        '</li>';
        
        element = null;
        klass = null;
        options = null;
        thisInputErrors = null;
        type = null;
        wrapper = null;
        
        formHtml += thisInputHtml;
    }
    formHtml += '</ul>' +
                '</form>';
                
    return( formHtml );
}

// $.fn is an alias for jQuery.prototype. It allows the creation of custom 
// jQuery functions.

// calling `serializeArray` on a form generates data of the form 
// [ { name: 'greekLetter', value: 'alpha' } ]. this function remaps it to the 
// form { greekLetter: 'alpha' }.
$.fn.serializeObject = function(  ) {
    
    object = {  };
    reference = this.serializeArray(  );
    
    for ( var i = 0; i < reference.length; i++ ) {
        
        var entry = reference[ i ];
        object[ entry.name ] = entry.value;
    }
    
    return( object );
}