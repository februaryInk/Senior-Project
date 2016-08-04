SelectButton.prototype = Object.create( Button.prototype, { constructor: { value: SelectButton } } );

function SelectButton ( action, editor, node, parent ) {
    
    Button.call( this, action, editor, node, parent );
    
    this.nested = ( this.parent.prototype === Button );
    this.value = $( node ).data( 'value' );
    
    this.addHandle(  );
    this.addStyle(  );
    this.activate(  );
}

SelectButton.prototype.addHandle = function (  ) {
    
    var selector = this.action + '-' + this.value + '-' + this.editor.uniqueId;
    
    $( this.node ).addClass( selector );
    this.selector = '.' + selector;
}

SelectButton.prototype.clickFunction = function (  ) {
    
    this.textarea[ 'set' + this.action.charAt( 0 ).toUpperCase(  ) + this.action.slice( 1 ) ]( this.value );
    
    if ( this.nested ) {
        this.parent.toBeClosed = true;
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
