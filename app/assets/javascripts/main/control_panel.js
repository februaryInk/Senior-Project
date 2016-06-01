ControlPanel = function ( editor, htmlPath, node ) {
    
    this.node = node;
    this.editor = editor;
    this.selector = '.js-editor-control-panel-' + editor.uniqueId;
    
    this.buttons = {
        intermediate: {  },
        select: {  },
        special: {  },
        toggle: {  }
    };
    
    this.buttonRegexes = {
        bold: />B\b/,
        italic: />I\b/,
        redo: null,
        underline: />U\b/,
        undo: null
    }

    this.buttonTags = {
        bold: 'B',
        italic: 'I',
        redo: null,
        underline: 'U',
        undo: null
    }
    
    this.build( htmlPath );
}

ControlPanel.prototype.buttonFunctions = {
    intermediate: function (  ) {
    },
    select: function (  ) {
    },
    toggle: function ( button ) {
        var test = button.editor.textarea.testPresenceinSelection( button.action, button.action, button.tag, button.testRegex );
    
        console.log( test );
        console.log( 'Clicked ' + button.action + '.' );
        
        if ( test ) {
            button.editor.textarea[ 'remove' + button.action.charAt( 0 ).toUpperCase(  ) + button.action.slice( 1 ) ](  );
        } else {
            button.editor.textarea[ button.action ](  );
            button.editor.textarea.focus(  );
        }
        
        button.controlPanel.visualizeControlStates(  );
    }
}

ControlPanel.prototype.build = function ( htmlPath ) {
    
    $( this.node ).addClass( this.selector );
    
    var controlPanel = this;
    
    $( this.node ).load( htmlPath, function( data ) {
        setTimeout( function(  ) {
            buttons = $( controlPanel.node ).find( '.js-editor-button' );
            
            console.log( controlPanel );
            console.log( buttons.length );
            
            $( buttons ).each( function( index, element ) {
                
                var action = $( this ).data( 'action' );
                var clickFunction = function ( button ) { alert( 'Function not assigned.' ) };
                var method = $( this ).data( 'method' );
                
                if ( method in controlPanel.buttonFunctions ) {
                    clickFunction = controlPanel.buttonFunctions[ method ];
                } else {
                    console.log( action );
                    clickFunction = function ( button ) { 
                        controlPanel.editor.textarea[ action ](  );
                        button.editor.textarea.focus(  );
                    }
                }
                
                $( this ).addClass( 'js-' + action + '-' + controlPanel.editor.uniqueId );
                
                controlPanel.buttons[ method ][ action ] = new Button(
                    action,
                    clickFunction,
                    controlPanel,
                    controlPanel.editor,
                    null,
                    '.js-' + action + '-' + controlPanel.editor.uniqueId,
                    controlPanel.buttonTags[ action ],
                    controlPanel.buttonRegexes[ action ]
                );
            } );
        }, 500 );
    } );
}

ControlPanel.prototype.neutralizeControlStates = function (  ) {
    
    $.each( this.buttons.toggle, function( key, value ) {
        value.toggleOff(  );
    } );
}

ControlPanel.prototype.visualizeControlStates = function (  ) {
    
    console.log( 'Buttoning up.' );
        
    var test = {
        bold: this.editor.textarea.testPresenceinSelection( 'bold', 'bold', 'B', ( />B\b/ ) ),
        italic: this.editor.textarea.testPresenceinSelection( 'italic', 'italic', 'I', ( />I\b/ ) ),
        underline: this.editor.textarea.testPresenceinSelection( 'underline', 'underline', 'U', ( />U\b/ ) ),
        orderedList: this.editor.textarea.testPresenceinSelection( 'makeOrderedList', 'makeOrderedList', 'OL', ( />OL\b/ ) ),
        link: this.editor.textarea.testPresenceinSelection( 'makeLink', 'makeLink', 'A', ( />A\b/ ) ),
        quote: this.editor.textarea.testPresenceinSelection( 'increaseQuoteLevel', 'increaseQuoteLevel', 'blockquote', ( />blockquote\b/ ) )
    }
    
    $.each( this.buttons.toggle, function( key, value ) {
        if ( test[ key ] ) {
            console.log( 'Turn on ' + key );
            value.toggleOn(  );
        } else {
            console.log( 'Turn off ' + key );
            value.toggleOff(  );
        }
    } );
}
