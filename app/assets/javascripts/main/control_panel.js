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
    intermediate: function ( button ) {
        
        $.each( button.controlPanel.buttons.intermediate, function ( key, value ) {
            value.toBeOpened = false;
            
            if ( value.open ) {
                value.toBeClosed = true;
            }
        } );
        
        button.toBeOpened = true;
        
        button.controlPanel.visualizeControlStates(  );
        button.editor.textarea.focus(  );
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
    
    $.each( this.buttons.toggle, function ( key, value ) {
        value.toggleOff(  );
    } );
    
    $.each( this.buttons.intermediate, function ( key, value ) {
        if ( value.open ) {
            value.toBeClosed = true;
        }
    } );
    
    this.visualizeIntermediateStates(  );
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
    
    $.each( this.buttons.toggle, function ( key, value ) {
        if ( test[ key ] ) {
            console.log( 'Turn on ' + key );
            value.toggleOn(  );
        } else {
            console.log( 'Turn off ' + key );
            value.toggleOff(  );
        }
    } );
    
    this.visualizeIntermediateStates(  );
}

ControlPanel.prototype.visualizeIntermediateStates = function (  ) {
    
    $.each( this.buttons.intermediate, function ( key, value ) {
        
        var buttonHeight = value.initialHeight;
        var buttonWidth = value.initialWidth;
        
        if ( value.toBeClosed ) {
            $( value.selector ).siblings( '.js-sub-controls' ).css( 'display', 'none' );
            
            animateInSequence( value.selector, 
                [ {
                    height: 1.10 * buttonHeight,
                    lineHeight: 1.10 * buttonHeight,
                    marginBottom: -0.05 * buttonWidth,
                    marginLeft: -0.05 * buttonWidth,
                    marginRight: -0.05 * buttonWidth,
                    marginTop: -0.05 * buttonWidth,
                    width: 1.10 * buttonWidth
                }, {
                    height: buttonHeight,
                    lineHeight: buttonHeight,
                    marginBottom: 0,
                    marginLeft: 0,
                    marginRight: 0,
                    marginTop: 0,
                    width: buttonWidth
                } ], [ 
                    150,
                    150
                ]
            );
            
            value.toBeClosed = false;
            value.open = false;
        }
        
        if ( value.toBeOpened ) {
            animateInSequence( value.selector, 
                [ {
                    height: 0.80 * buttonHeight,
                    lineHeight: 0.80 * buttonHeight,
                    marginBottom: 0.10 * buttonWidth,
                    marginLeft: 0.10 * buttonWidth,
                    marginRight: 0.10 * buttonWidth,
                    marginTop: 0.10 * buttonWidth,
                    width: 0.80 * buttonWidth
                }, {
                    height: 0.90 * buttonHeight,
                    lineHeight: 0.90 * buttonHeight,
                    marginBottom: 0.05 * buttonWidth,
                    marginLeft: 0.05 * buttonWidth,
                    marginRight: 0.05 * buttonWidth,
                    marginTop: 0.05 * buttonWidth,
                    width: 0.90 * buttonWidth
                } ], [ 
                    150,
                    150
                ]
            );
            
            $( value.selector ).siblings( '.js-sub-controls' ).css( 'display', 'block' );
            
            animateWithPause( value.selector + ' ~ ' + 'div ' + '.js-editor-button',
                [ { 
                    height: 1.25 * buttonHeight, 
                    lineHeight: 1.25 * buttonHeight,
                    marginLeft: -0.125 * buttonWidth,
                    marginRight: -0.125 * buttonWidth,
                    marginTop: -0.125 * buttonHeight,
                    width: 1.25 * buttonWidth 
                },
                { 
                    height: 0.9 * buttonHeight, 
                    lineHeight: 0.9 * buttonHeight,
                    marginLeft: 0.05 * buttonWidth,
                    marginRight: 0.05 * buttonWidth,
                    marginTop: 0.05 * buttonHeight,
                    width: 0.9 * buttonWidth
                },
                { 
                    height: buttonHeight, 
                    lineHeight: buttonHeight,
                    marginLeft: 0,
                    marginRight: 0,
                    marginTop: 0,
                    width: buttonWidth
                } ],
                [
                    200,
                    200,
                    200
                ],
                100
            );
            
            value.toBeOpened = false;
            value.open = true;
        }
    } );
}
