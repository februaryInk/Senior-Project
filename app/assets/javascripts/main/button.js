var Button = function ( action, clickFunction, controlPanel, editor, parent, selector, tag, testRegex ) {
    
    this.action = action;
    this.clickFunction = clickFunction;
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
        button.clickFunction( button );
    } );
}

Button.prototype.toggleOff = function (  ) {
    
    $( this.selector ).removeClass( '-open' );
}

Button.prototype.toggleOn = function (  ) {
    
    $( this.selector ).addClass( '-open' );
}
