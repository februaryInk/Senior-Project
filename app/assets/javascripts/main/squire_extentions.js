// test if the selected region has a given formatting.
Squire.prototype.testPresenceinSelection = function ( name, action, tag, testRegex ) {
    
    // identifies the ancestors of the cursor location text, i.e., `DIV>B>I`.
    var path = this.getPath(  );
    // is the testRegex regex in the path, or is the selection in the tag tag?
    var test = ( testRegex.test( path ) || this.hasFormat( tag ) );
    
    return( name == action && test );
}

Squire.prototype.command = function ( method, arg1, arg2 ) {
    this[ method ]( arg1, arg2 );
    return( this.focus(  ) );
}

// TODO: take a look at increaseQuoteLevel and see how it inserts block-level 
// tag elements.
Squire.prototype.heading = function (  ) {
    
    this.command( 'changeFormat', { tag: 'EM' } );
}

Squire.prototype.orderedList = function (  ) {
    
    this.makeOrderedList(  );
}

Squire.prototype.quote = function (  ) {
    
    this.increaseQuoteLevel(  );
}

Squire.prototype.removeHeading = function (  ) {
    
    this.command( 'changeFormat', null, { tag: 'EM' } );
}

Squire.prototype.removeOrderedList = function (  ) {
    
    this.decreaseListLevel(  );
}

Squire.prototype.removeQuote = function (  ) {
    
    this.decreaseQuoteLevel(  );
}
