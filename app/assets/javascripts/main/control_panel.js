function ControlPanel ( editor, htmlPath, node ) {
    
    this.node = node;
    this.editor = editor;
    this.selector = '.js-editor-control-panel-' + editor.uniqueId;
    
    this.buttons = {
        intermediate: {  },
        select: {  },
        special: {  },
        toggle: {  }
    };
    
    this.build( htmlPath );
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
                var method = $( this ).data( 'method' );
                
                $( element ).addClass( 'js-' + action + '-' + controlPanel.editor.uniqueId );
                
                if ( method == 'intermediate' ) {
                    controlPanel.buttons[ method ][ action ] = new IntermediateButton(
                      action,
                      controlPanel,
                      controlPanel.editor,
                      '.js-' + action + '-' + controlPanel.editor.uniqueId
                  );
                } else if ( method == 'select' ) {
                    controlPanel.buttons[ method ][ action ] = new SelectButton(
                        action,
                        controlPanel,
                        controlPanel.editor,
                        '.js-' + action + '-' + controlPanel.editor.uniqueId
                    );
                } else if ( method == 'toggle' ) {
                    controlPanel.buttons[ method ][ action ] = new ToggleButton(
                        action,
                        controlPanel,
                        controlPanel.editor,
                        '.js-' + action + '-' + controlPanel.editor.uniqueId
                    );
                } else {
                    controlPanel.buttons[ 'special' ][ action ] = new Button(
                        action,
                        controlPanel,
                        controlPanel.editor,
                        '.js-' + action + '-' + controlPanel.editor.uniqueId
                    );
                }
            } );
        }, 500 );
    } );
}

ControlPanel.prototype.neutralizeControlStates = function (  ) {
    
    $.each( this.buttons.toggle, function ( key, value ) {
        value.toggleOff(  );
    } );
    
    $.each( this.buttons.intermediate, function ( key, value ) {
        if ( value.isOpen ) {
            value.toBeClosed = true;
        }
    } );
    
    this.visualizeIntermediateStates(  );
}

ControlPanel.prototype.visualizeControlStates = function (  ) {
        
    this.visualizeToggleStates(  );
    this.visualizeIntermediateStates(  );
}

ControlPanel.prototype.visualizeIntermediateStates = function (  ) {
    
    $.each( this.buttons.intermediate, function ( key, value ) {
        
        if ( value.toBeClosed ) {
            value.close(  );
        }
        
        if ( value.toBeOpened ) {
            value.open(  );
        }
    } );
}

ControlPanel.prototype.visualizeToggleStates = function (  ) {
    
    $.each( this.buttons.toggle, function ( key, value ) {
        var test = this.editor.textarea.testPresenceinSelection( value.action, value.action, value.tag, value.testRegex );
        
        if ( test ) {
            console.log( 'Turn on ' + key );
            value.toggleOn(  );
        } else {
            console.log( 'Turn off ' + key );
            value.toggleOff(  );
        }
    } );
}
