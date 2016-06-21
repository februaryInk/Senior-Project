SelectButton.prototype = Object.create( Button.prototype, { constructor: { value: SelectButton } } );

function SelectButton ( action, controlPanel, editor, selector, textarea ) {
    
    Button.call( this, action, controlPanel, editor, selector, textarea );
    
    this.parent = controlPanel.buttons.intermediate[ $( selector ).data( 'parent' ) ];
    
    if ( this.parent.action === 'fontSize' ) {
        this.size = $( selector ).data( 'size' ) + 'px';
    }
    
    this.activate(  );
}

SelectButton.prototype.clickFunction = function (  ) {
    
    if ( this.parent.action == 'fontSize' ) {
        this.textarea.setFontSize( this.size );
        this.parent.toBeClosed = true;
        this.textarea.focus(  );
        this.controlPanel.visualizeControlStates(  );
    }
}
