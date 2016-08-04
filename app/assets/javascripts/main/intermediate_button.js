IntermediateButton.prototype = Object.create( Button.prototype, { constructor: { value: IntermediateButton } } );

function IntermediateButton ( action, editor, node, parent ) {
    
    Button.call( this, action, editor, node, parent );
    
    this.isOpen = false;
    this.toBeClosed = false;
    this.toBeOpened = false;
    
    this.addHandle(  );
    this.addStyle(  );
    this.buildSubButtons(  );
    
    this.initialHeight = $( node ).outerHeight(  );
    this.initialWidth = $( node ).outerWidth(  );
    
    this.activate(  );
}

IntermediateButton.prototype.buildSubButtons = function (  ) {
    
    var button = this;
    var subButtonsNode = document.createElement( 'div' );
    
    this.subButtonsSelector = '.' + this.action + '-sub-buttons-' + this.editor.uniqueId;
    
    $( subButtonsNode ).addClass( this.editor.config.subButtonsContainerStyleClass );
    $( subButtonsNode ).addClass( this.subButtonsSelector.slice( 1 ) );
    
    $( this.node ).after( subButtonsNode );
    
    while ( $( button.node ).children(  ).length > 0 ) {
        $( subButtonsNode ).append( $( button.node ).children(  )[ 0 ] );
    }
    
    $( subButtonsNode ).find( 'span' ).each( function ( index, element ) {
        
        var action = $( element ).data( 'action' );
        
        new SelectButton(
            action,
            button.editor,
            element,
            button
        );
    } );
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
    this.textarea.focus(  );
}

IntermediateButton.prototype.close = function (  ) {
    
    var buttonHeight = this.initialHeight;
    var buttonWidth = this.initialWidth;
    
    $( this.subButtonsSelector ).css( 'display', 'none' );
    
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
    
    $( this.subButtonsSelector ).css( 'display', 'block' );
    
    animateWithPause( this.subButtonsSelector + ' span',
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
