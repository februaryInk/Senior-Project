$( document ).ready( function (  ) {
    if ( $( '.js-squire-standin' ).length ) {
        new SquireUI( {
            buildPath: '/shared/',
            replace: '.js-squire-standin'
        } );
    } );
} );
    
Squire.prototype.testPresenceinSelection = function( name, action, format, validation ) {
    var path = this.getPath(  ),
        test = ( validation.test( path ) | this.hasFormat( format ) );
    if ( name == action && test ) {
        return true;
    } else {
        return false;
    }
};

SquireUI = function( options ) {
    if ( typeof options.buildPath == 'undefined' ) {
        options.buildPath = '/';
    }
    
    var container;
    var editor;
    
    if ( options.replace ) {
        container = $( options.replace ).parent(  );
        $( options.replace ).remove(  );
    } else if ( options.div ) {
        container = $( options.div );
    } else {
        throw new Error( 'No element was defined for the editor to inject to.' );
    }
    
    var editorDiv = document.createElement( 'div' );
    var controlsDiv = document.createElement( 'div' );
    
    controlsDiv.className = 'editor-ui';
    editorDiv.className = 'editor-textarea';
    editorDiv.height = options.height;
    
    $( container ).append( controlsDiv );
    $( container ).append( editorDiv );
    
    editor = new Squire( editorDiv );
    $( controlsDiv ).load( options.buildPath + 'squire_ui.html' );
    
    $( document ).on( 'click', '.js-editor-toggle', function(  ) {
        var action = $( this ).data( 'action' );

        test = {
            value: $( this ).data( 'action' ),
            testBold: editor.testPresenceinSelection( 'bold',
                action, 'B', ( />B\b/ ) ),
            testItalic: editor.testPresenceinSelection( 'italic',
                action, 'I', ( />I\b/ ) ),
            testUnderline: editor.testPresenceinSelection( 
                'underline', action, 'U', ( />U\b/ ) ),
            testOrderedList: editor.testPresenceinSelection( 
                'makeOrderedList', action, 'OL', ( />OL\b/ ) ),
            testLink: editor.testPresenceinSelection( 'makeLink',
                action, 'A', ( />A\b/ ) ),
            testQuote: editor.testPresenceinSelection( 
                'increaseQuoteLevel', action, 'blockquote', ( 
                    />blockquote\b/ ) ),
            isNotValue: function ( a ) {return ( a == action && this.value !== '' ); }
        };
        
        if ( test.testBold | test.testItalic | test.testUnderline | test.testOrderedList | test.testLink | test.testQuote ) {
            if ( test.testBold ) editor.removeBold(  );
            if ( test.testItalic ) editor.removeItalic(  );
            if ( test.testUnderline ) editor.removeUnderline(  );
            if ( test.testLink ) editor.removeLink(  );
            if ( test.testOrderedList ) editor.removeList(  );
            if ( test.testQuote ) editor.decreaseQuoteLevel(  );
        } else if ( test.isNotValue( 'makeLink' ) | test.isNotValue( 'insertImage' ) | test.isNotValue( 'selectFont' ) ) {
        // do nothing. these are dropdowns.
        } else {
            editor[action](  );
            editor.focus(  );
        }
    } );

    return editor;
};
