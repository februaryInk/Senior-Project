Squire.prototype.visualizeControlStates = function (  ) {
    console.log( 'Buttoning up.' );
        
    var test = {
        testBold: this.testPresenceinSelection( 'bold', 'bold', 'B', ( />B\b/ ) ),
        testItalic: this.testPresenceinSelection( 'italic', 'italic', 'I', ( />I\b/ ) ),
        testUnderline: this.testPresenceinSelection( 'underline', 'underline', 'U', ( />U\b/ ) ),
        testOrderedList: this.testPresenceinSelection( 'makeOrderedList', 'makeOrderedList', 'OL', ( />OL\b/ ) ),
        testLink: this.testPresenceinSelection( 'makeLink', 'makeLink', 'A', ( />A\b/ ) ),
        testQuote: this.testPresenceinSelection( 'increaseQuoteLevel', 'increaseQuoteLevel', 'blockquote', ( />blockquote\b/ ) )
    }
    
    if ( test.testBold ) { this.toggleOn( 'bold' ); } else { this.toggleOff( 'bold' ); }
    if ( test.testItalic ) { this.toggleOn( 'italic' ); } else { this.toggleOff( 'italic' ); }
    if ( test.testUnderline ) { this.toggleOn( 'underline' ); } else { this.toggleOff( 'underline' ); }
}

Squire.prototype.toggleOff = function ( action ) {
    $( '.js-editor-toggle[ data-action="' + action + '" ]' ).removeClass( '-open' );
}

Squire.prototype.toggleOn = function ( action ) {
    $( '.js-editor-toggle[ data-action="' + action + '" ]' ).addClass( '-open' );
}

SquireUI = function ( options ) {
    
    var container;
    var editor;
    var uniqueId = Date.now(  );
    
    if ( options.replace ) {
        container = $( options.replace ).parent(  );
        $( options.replace ).remove(  );
    } else if ( options.containerDiv ) {
        container = $( options.containerDiv );
    } else {
        throw new Error( 'No element was defined for the editor to inject into.' );
    }
    
    var editorDiv = document.createElement( 'div' );
    var controlsDiv = document.createElement( 'div' );
    
    controlsDiv.className = 'editor-ui';
    controlsDiv.id = 'controls-' + uniqueId;
    
    editorDiv.className = 'editor-textarea';
    editorDiv.height = options.height;
    editorDiv.id = 'editor-' + uniqueId;
    
    $( container ).append( controlsDiv );
    $( container ).append( editorDiv );
    
    editor = new Squire( editorDiv );
    editor.id = 'editor-' + uniqueId;
    editor.controlPanel = 'controls-' + uniqueId;
    
    $( controlsDiv ).load( options.htmlPath );
    
    $( document ).on( 'blur', '.editor-textarea', function(  ) {
        
    } );
    
    $( document ).on( 'click select', '.editor-textarea', function(  ) {
        editor.visualizeControlStates(  );
    } );
    
    $( document ).on( 'keyup', '.editor-textarea', function( event ) {
        var key = event.keyCode || event.which;
        console.log( 'document: ' + event.keyCode || event.which );
        
        if ( key == '37' || key == '38' || key == '39' || key == '40' ) {
            editor.visualizeControlStates(  );
        }
    } );
    
    $( document ).on( 'click', '.js-editor-toggle', function(  ) {
        var action = $( this ).data( 'action' );

        var test = {
            value: action,
            testBold: editor.testPresenceinSelection( 'bold', action, 'B', ( />B\b/ ) ),
            testItalic: editor.testPresenceinSelection( 'italic', action, 'I', ( />I\b/ ) ),
            testUnderline: editor.testPresenceinSelection( 'underline', action, 'U', ( />U\b/ ) ),
            testOrderedList: editor.testPresenceinSelection( 'makeOrderedList', action, 'OL', ( />OL\b/ ) ),
            testLink: editor.testPresenceinSelection( 'makeLink', action, 'A', ( />A\b/ ) ),
            testQuote: editor.testPresenceinSelection( 'increaseQuoteLevel', action, 'blockquote', ( />blockquote\b/ ) ),
            isNotValue: function ( a ) { return ( a == action && this.value !== '' ); }
        };
        
        if ( test.testBold | test.testItalic | test.testUnderline | test.testOrderedList | test.testLink | test.testQuote ) {
            if ( test.testBold ) editor.removeBold(  );
            if ( test.testItalic ) editor.removeItalic(  );
            if ( test.testUnderline ) editor.removeUnderline(  );
            if ( test.testLink ) editor.removeLink(  );
            if ( test.testOrderedList ) editor.removeList(  );
            if ( test.testQuote ) editor.decreaseQuoteLevel(  );
        } else if ( test.isNotValue( 'makeLink' ) || test.isNotValue( 'insertImage' ) || test.isNotValue( 'selectFont' ) ) {
        // do nothing. these are popups.
        } else {
            editor[action](  );
            editor.focus(  );
        }
        
        editor.visualizeControlStates(  );
    } );

    return( editor );
}
