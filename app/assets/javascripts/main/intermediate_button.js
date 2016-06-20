IntermediateButton.prototype = Object.create( Button.prototype, { constructor: { value: IntermediateButton } } );

function IntermediateButton ( action, controlPanel, editor, selector ) {
    
    Button.call( this, action, controlPanel, editor, selector );
    
    this.initialHeight = $( selector ).outerHeight(  );
    this.initialWidth = $( selector ).outerWidth(  );
    this.isOpen = false;
    this.toBeClosed = false;
    this.toBeOpened = false;
    
    this.activate(  );
}

IntermediateButton.prototype.clickFunction = function (  ) {
    
    $.each( this.controlPanel.buttons.intermediate, function ( key, value ) {
        value.toBeOpened = false;
        
        if ( value.isOpen ) {
            value.toBeClosed = true;
        }
    } );
    
    this.toBeClosed = this.isOpen;
    this.toBeOpened = !this.isOpen;
    
    console.log( 'Open: ' + this.isOpen );
    console.log( 'Will close: ' + this.toBeClosed );
    console.log( 'Will open: ' + this.toBeOpened );

    this.controlPanel.visualizeControlStates(  );
    this.editor.textarea.focus(  );
}

IntermediateButton.prototype.close = function (  ) {
    
    var buttonHeight = this.initialHeight;
    var buttonWidth = this.initialWidth;
    
    $( this.selector ).siblings( '.js-sub-controls' ).css( 'display', 'none' );
            
    animateInSequence( this.selector, 
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
    
    this.toBeClosed = false;
    this.isOpen = false;
}

IntermediateButton.prototype.open = function (  ) {
    
    var buttonHeight = this.initialHeight;
    var buttonWidth = this.initialWidth;
    
    animateInSequence( this.selector, 
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
    
    $( this.selector ).siblings( '.js-sub-controls' ).css( 'display', 'block' );
    
    animateWithPause( this.selector + ' ~ ' + 'div ' + '.js-editor-button',
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
    
    this.toBeOpened = false;
    this.isOpen = true;
}
