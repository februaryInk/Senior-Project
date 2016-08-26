Button.prototype = Object.create( Control.prototype, { constructor: { value: Button } } );

function Button ( action, editor, node, parent ) {
    
    Control.call( this, action, editor, node, parent );
    
    if ( this.constructor === Button ) {
        this.addHandle(  );
        this.addStyle(  );
        this.activate(  );
    }
}

Button.prototype.addStyle = function (  ) {
    
    $( this.node ).addClass( this.editor.config.buttonStyleClass );
}
