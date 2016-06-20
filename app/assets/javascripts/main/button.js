function Button ( action, controlPanel, editor, selector ) {
    
    this.action = action;
    this.controlPanel = controlPanel;
    this.editor = editor;
    this.selector = selector;
    
    if ( this.constructor == Button ) {
        this.activate(  );
    }
}

Button.prototype.activate = function (  ) {
    
    var button = this;
    
    $( document ).on( 'click', this.selector, function(  ) {
        button.clickFunction(  );
    } );
}

Button.prototype.clickFunction = function (  ) {
    
    this.editor.textarea[ this.action ](  );
    this.editor.textarea.focus(  );
}
