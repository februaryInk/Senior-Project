ToggleButton.prototype = Object.create( Button.prototype, { constructor: { value: ToggleButton } } );

function ToggleButton ( action, editor, node, parent ) {
    
    Button.call( this, action, editor, node );
    
    this.tag = this.tags[ action ];
    this.testRegex = this.testRegexes[ action ];
    
    this.addHandle(  );
    this.addStyle(  );
    this.activate(  );
}

ToggleButton.prototype.clickFunction = function (  ) {
    
    var test = this.textarea.testPresenceinSelection( this.action, this.action, this.tag, this.testRegex );
    
    console.log( test );
    console.log( 'Clicked ' + this.action + '.' );
    
    if ( test ) {
        var removeCommand = 'remove' + this.action.charAt( 0 ).toUpperCase(  ) + this.action.slice( 1 );
        this.editor.textarea[ removeCommand ](  );
    } else {
        this.textarea[ this.action ](  );
        this.textarea.focus(  );
    }
    
    this.controlPanel.visualizeControlStates(  );
}

ToggleButton.prototype.testRegexes = {
    bold: />B\b/,
    heading: />H2\b/,
    italic: />I\b/,
    quote: />blockquote\b/,
    orderedList: />OL\b/,
    strikethrough: />STRIKE\b/,
    underline: />U\b/,
}

ToggleButton.prototype.tags = {
    bold: 'B',
    heading: 'H2',
    italic: 'I',
    quote: 'blockquote',
    orderedList: 'OL',
    strikethrough: 'STRIKE',
    underline: 'U',
}

// TODO: close, like intemediate buttons.
ToggleButton.prototype.close = function (  ) {
    
    $( this.selector ).removeClass( '-open' );
}

// TODO: open, like intermediate buttons.
ToggleButton.prototype.open = function (  ) {
    
    $( this.selector ).addClass( '-open' );
}
