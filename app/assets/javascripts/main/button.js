var Button = function ( action, controlPanel, editor, parent, selector, tag, testRegex ) {
    
    this.action = action;
    this.controlPanel = controlPanel;
    this.editor = editor;
    this.parent = parent;
    this.selector = selector;
    this.tag = tag;
    this.testRegex = testRegex;
    
    this.activate(  );
}

Button.prototype.activate = function (  ) {
    
    console.log( 'Button activated.' );
    
    var button = this;
    
    $( document ).on( 'click', this.selector, function(  ) {
        
        console.log( 'Clicked ' + button.action + '.' );
        
        var test = button.editor.textarea.testPresenceinSelection( button.action, button.action, button.tag, button.testRegex );
        
        console.log( test );
        
        if ( test ) {
            button.editor.textarea[ 'remove' + button.action.charAt( 0 ).toUpperCase(  ) + button.action.slice( 1 ) ](  );
        } else {
            button.editor.textarea[ button.action ](  );
            button.editor.textarea.focus(  );
        }
        
        button.controlPanel.visualizeControlStates(  );
    } );
}

Button.prototype.toggleOff = function (  ) {
    
    $( this.selector ).removeClass( '-open' );
}

Button.prototype.toggleOn = function (  ) {
    
    $( this.selector ).addClass( '-open' );
}
