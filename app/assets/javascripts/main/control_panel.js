ControlPanel = function ( editor, htmlPath, node ) {
    
    this.node = node;
    this.editor = editor;
    this.selector = '.js-editor-control-panel-' + editor.uniqueId;
    
    this.buttons = {
        intermediate: {  },
        select: {  },
        toggle: {  }
    };
    
    this.buttonRegexes = {
        bold: />B\b/,
        italic: />I\b/,
        underline: />U\b/
    }

    this.buttonTags = {
        bold: 'B',
        italic: 'I',
        underline: 'U'
    }
    
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
                
                $( this ).addClass( 'js-' + action + '-' + controlPanel.editor.uniqueId );
                
                controlPanel.buttons[ method ][ action ] = new Button(
                    action,
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

ControlPanel.prototype.visualizeControlStates = function (  ) {
    
    console.log( 'Buttoning up.' );
        
    var test = {
        testBold: this.editor.textarea.testPresenceinSelection( 'bold', 'bold', 'B', ( />B\b/ ) ),
        testItalic: this.editor.textarea.testPresenceinSelection( 'italic', 'italic', 'I', ( />I\b/ ) ),
        testUnderline: this.editor.textarea.testPresenceinSelection( 'underline', 'underline', 'U', ( />U\b/ ) ),
        testOrderedList: this.editor.textarea.testPresenceinSelection( 'makeOrderedList', 'makeOrderedList', 'OL', ( />OL\b/ ) ),
        testLink: this.editor.textarea.testPresenceinSelection( 'makeLink', 'makeLink', 'A', ( />A\b/ ) ),
        testQuote: this.editor.textarea.testPresenceinSelection( 'increaseQuoteLevel', 'increaseQuoteLevel', 'blockquote', ( />blockquote\b/ ) )
    }
    
    if ( test.testBold ) { this.buttons.toggle.bold.toggleOn(  ); } else { this.buttons.toggle.bold.toggleOff(  ); }
    if ( test.testItalic ) { this.buttons.toggle.italic.toggleOn(  ); } else { this.buttons.toggle.italic.toggleOff(  ); }
    if ( test.testUnderline ) { this.buttons.toggle.underline.toggleOn(  ); } else { this.buttons.toggle.underline.toggleOff(  ); }
}
