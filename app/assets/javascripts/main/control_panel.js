function ControlPanel ( htmlPath, editor, node ) {
    
    this.node = node;
    this.editor = editor;
    this.selector = '.js-editor-control-panel-' + editor.uniqueId;
    this.textarea = editor.textarea;
    
    this.buttons = {
        intermediate: {  },
        select: {  },
        special: {  },
        toggle: {  }
    };
    
    this.build( htmlPath );
}

ControlPanel.prototype.buttonTypes = {
    alignCenter: 'select',
    alignJustify: 'select',
    alignLeft: 'select',
    alignRight: 'select',
    bold: 'toggle',
    fontSize: 'select',
    heading: 'toggle',
    italic: 'toggle',
    open: 'intermediate',
    orderedList: 'toggle',
    quote: 'toggle',
    redo: '',
    textAlignment: 'select',
    underline: 'toggle',
    undo: ''
}

ControlPanel.prototype.build = function ( htmlPath ) {
    
    var controlPanel = this;
    var controlPanelDiv = $( this.node );
    
    controlPanelDiv.addClass( this.editor.config.controlPanelStyleClass );
    
    $( controlPanelDiv ).load( htmlPath, function ( data ) {
        
        setTimeout( function(  ) {
            
            controlPanel.buildButtons( controlPanelDiv );
        }, 500 );
    } );
}

ControlPanel.prototype.buildButtons = function ( container ) {
    
    var controlPanel = this;
    
    // TODO: If there are no nested buttons to worry about, switch to iterating
    // over only button elements.
    $( container ).children(  ).each( function ( index, element ) {
        
        if ( $( element ).prop( 'tagName' ) === 'SPAN' ) {
            controlPanel.buildButton( element );
        } else {
            if ( $( element ).children(  ).length > 0 ) {
                controlPanel.buildButtons( element );
            }
        }
    } );
}

ControlPanel.prototype.buildButton = function ( node ) {
    
    var action = $( node ).data( 'action' );
    var type = this.buttonTypes[ action ] || '';
    
    var constructor = window[ ( type + 'Button' ).charAt( 0 ).toUpperCase(  ) + ( type + 'Button' ).slice( 1 ) ];
    
    this.buttons[ type ? type : 'special' ][ action ] = new constructor(
        action,
        this.editor,
        node,
        this
    );
}

ControlPanel.prototype.neutralizeControlStates = function (  ) {
    
    $.each( this.buttons.toggle, function ( key, value ) {
        value.toggleOff(  );
    } );
    
    $.each( this.buttons.select, function ( key, value ) {
        value.close(  );
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
    this.visualizeSelectStates(  );
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

ControlPanel.prototype.visualizeSelectStates = function (  ) {
    
    $.each( this.buttons.select, function ( key, value ) {
        
        var regex = '';
        var test = false;
        
        if ( this.nested ) {
            if ( value.action === 'fontSize' ) {
                test = this.editor.textarea.getFontInfo(  ).size === this.size ||
                    this.editor.textarea.getFontInfo(  ).size === undefined && this.size === '16px';
            }
        } else {
            regex = new RegExp( value.action.replace( /([A-Z])/g, function ( x, y ) { return '-' + y.toLowerCase(  ) } ) );
            test = this.textarea.testPresenceinSelection( value.action, value.action, value.action, regex );
        }
        
        if ( test ) {
            console.log( 'Turn on ' + key );
            value.open(  );
        } else {
            console.log( 'Turn off ' + key );
            value.close(  );
        }
    } );
}

ControlPanel.prototype.visualizeToggleStates = function (  ) {
    
    $.each( this.buttons.toggle, function ( key, value ) {
        
        var test = this.editor.textarea.testPresenceinSelection( value.action, value.action, value.tag, value.testRegex );
        
        if ( test ) {
            value.toggleOn(  );
        } else {
            value.toggleOff(  );
        }
    } );
}
