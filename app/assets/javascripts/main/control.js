function Control ( action, editor, node, parent ) {
    
    this.action = action;
    this.controlPanel = editor.controlPanel;
    this.editor = editor;
    this.node = node;
    this.parent = parent;
    this.selector = '';
    this.textarea = editor.textarea;
    
    if ( this.constructor === Control ) {
        this.addHandle(  );
    }
}

Control.prototype.activate = function (  ) {
    
    var control = this;
    
    $( document ).on( 'click', this.selector, function(  ) {
        control.clickFunction(  );
    } );
}

Control.prototype.addHandle = function (  ) {
    
    var selector = this.action + '-' + this.editor.uniqueId;
    
    $( this.node ).addClass( selector );
    this.selector = '.' + selector;
}

Control.prototype.clickFunction = function (  ) {
    
    this.textarea[ this.action ](  );
    this.textarea.focus(  );
}
