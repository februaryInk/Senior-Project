// test if the selected region has a given formatting.
Squire.prototype.testPresenceinSelection = function( name, action, format, validation ) {
    
    // identifies the ancestors of the cursor location text, i.e., `DIV>B>I`.
    var path = this.getPath(  );
    // is the validation regex in the path, or is the selection in the format tag?
    var test = ( validation.test( path ) || this.hasFormat( format ) );
    
    return( name == action && test );
}
