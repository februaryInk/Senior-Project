SelectButton.prototype = Object.create( Button.prototype, { constructor: { value: SelectButton } } );

function SelectButton ( action, controlPanel, editor, selector ) {
    
    Button.call( this, action, controlPanel, editor, selector );
    
    if ( action === 'fontSize' ) {
        this.size = $( selector ).data( 'size' );
    }
    
    this.activate(  );
}

SelectButton.prototype.clickFunction = function (  ) {
    
    console.log( 'Fill me in!' );
}
