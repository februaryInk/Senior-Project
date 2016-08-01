SelectButton.prototype = Object.create( Button.prototype, { constructor: { value: SelectButton } } );

function SelectButton ( action, controlPanel, editor, selector, textarea ) {
    
    Button.call( this, action, controlPanel, editor, selector, textarea );
    
    this.nested = false;
    
    if ( $( selector ).data( 'parent' ) ) {
        this.nested = true;
        this.parent = controlPanel.buttons.intermediate[ $( selector ).data( 'parent' ) ];
        
        if ( this.parent.action === 'fontSize' ) {
            this.size = $( selector ).data( 'size' ) + 'px';
        }
    }
    
    this.activate(  );
}

SelectButton.prototype.clickFunction = function (  ) {
    
    if ( this.nested ) {
        if ( this.parent.action == 'fontSize' ) {
            this.textarea.setFontSize( this.size );
        }
        
        this.parent.toBeClosed = true;
    } else {
        this.editor.textarea[ this.action ](  );
        this.editor.textarea.focus(  );
    }
    
    this.textarea.focus(  );
    this.controlPanel.visualizeControlStates(  );
}

SelectButton.prototype.close = function (  ) {
    
    $( this.selector ).removeClass( '-open' );
}

SelectButton.prototype.open = function (  ) {
    
    $( this.selector ).addClass( '-open' );
}
