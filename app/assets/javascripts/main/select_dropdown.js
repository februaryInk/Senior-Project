SelectDropdown.prototype = Object.create( Control.prototype, { constructor: { value: SelectDropdown } } );

function SelectDropdown ( action, editor, node ) {
    
    Control.call( this, action, editor, node, parent );
    
    this.value = null;
    
    this.addHandle(  );
    this.addStyle(  );
    this.activate(  );
}

SelectDropdown.prototype.activate = function (  ) {
    
    var selectDropdown = this;
    
    $( document ).on( 'change', this.selector, function ( element ) {
        
        selectDropdown.clickFunction(  );
    } );
}

SelectDropdown.prototype.addStyle = function (  ) {
    
    $( this.node ).addClass( this.editor.config.dropdownStyleClass );
}

SelectDropdown.prototype.clickFunction = function (  ) {
    
    this.value = $( this.selector ).val(  );
    
    this.textarea[ 'set' + this.action.charAt( 0 ).toUpperCase(  ) + this.action.slice( 1 ) ]( this.value );

    this.textarea.focus(  );
    this.controlPanel.visualizeControlStates(  );
}
