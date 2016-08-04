function Button ( action, editor, node, parent ) {
    
    this.action = action;
    this.controlPanel = editor.controlPanel;
    this.editor = editor;
    this.node = node;
    this.parent = parent;
    this.selector = '';
    this.textarea = editor.textarea;
    
    if ( this.constructor === Button ) {
        this.addHandle(  );
        this.addStyle(  );
        this.activate(  );
    }
}

Button.prototype.activate = function (  ) {
    
    var button = this;
    
    $( document ).on( 'click', this.selector, function(  ) {
        button.clickFunction(  );
    } );
}

Button.prototype.addHandle = function (  ) {
    
    var selector = this.action + '-' + this.editor.uniqueId;
    
    $( this.node ).addClass( selector );
    this.selector = '.' + selector;
}

Button.prototype.addStyle = function (  ) {
    
    $( this.node ).addClass( this.editor.config.buttonStyleClass );
}

Button.prototype.clickFunction = function (  ) {
    
    this.editor.textarea[ this.action ](  );
    this.editor.textarea.focus(  );
}
