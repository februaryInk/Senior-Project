Textarea.prototype = Object.create( Squire.prototype, { constructor: { value: Textarea } } );

function Textarea ( node ) {
    
    Squire.call( this, node, { blockTag: 'P' } );
}

// test if the selected region has a given formatting.
Textarea.prototype.testPresenceinSelection = function ( name, action, tag, testRegex ) {
    
    // identifies the ancestors of the cursor location text, i.e., `DIV>B>I`.
    var path = this.getPath(  );
    // is the testRegex regex in the path, or is the selection in the tag tag?
    var test = ( testRegex.test( path ) || this.hasFormat( tag ) );
    
    return( name == action && test );
}

Textarea.prototype.addBlockHeading = function ( frag ) {
    
    return this.createElement( 'H2',
        this._config.tagAttributes.heading, [
            frag
        ]
    );
}

Textarea.prototype.command = function ( method, arg1, arg2 ) {
    
    this[ method ]( arg1, arg2 );
    return( this.focus(  ) );
}

Textarea.prototype.empty = function ( node ) {
    
    var frag = node.ownerDocument.createDocumentFragment();
    var childNodes = node.childNodes;
    var l = childNodes ? childNodes.length : 0;
    
    while ( l-- ) {
        frag.appendChild( node.firstChild );
    }
    
    return frag;
}

Textarea.prototype.getNearest = function ( node, root, tag, attributes ) {
    
    while ( node && node !== root ) {
        if ( this.hasTagAttributes( node, tag, attributes ) ) {
            return node;
        }
        node = node.parentNode;
    }
    
    return null;
}

Textarea.prototype.hasTagAttributes = function ( node, tag, attributes ) {
    
    if ( node.nodeName !== tag ) {
        return false;
    }
    
    for ( var attr in attributes ) {
        if ( node.getAttribute( attr ) !== attributes[ attr ] ) {
            return false;
        }
    }
    
    return true;
}

// TODO: take a look at increaseQuoteLevel and see how it inserts block-level 
// tag elements.
Textarea.prototype.heading = function (  ) {
    
    this.command( 'modifyBlocks', this.addBlockHeading );
}

Textarea.prototype.orderedList = function (  ) {
    
    this.makeOrderedList(  );
}

Textarea.prototype.quote = function (  ) {
    
    this.increaseQuoteLevel(  );
}

Textarea.prototype.removeBlockHeading = function ( frag ) {
    
    var root = this._root;
    var headings = frag.querySelectorAll( 'H2' );
    var textarea = this;
    
    Array.prototype.filter.call( headings, function ( el ) {
        
        return !textarea.getNearest( el.parentNode, root, 'H2' );
    } ).forEach( function ( el ) {
        
        textarea.replaceWith( el, textarea.empty( el ) );
    } );
    
    return frag;
}

Textarea.prototype.removeHeading = function (  ) {
    
    this.command( 'modifyBlocks', this.removeBlockHeading );
}

Textarea.prototype.removeOrderedList = function (  ) {
    
    this.decreaseListLevel(  );
}

Textarea.prototype.removeQuote = function (  ) {
    
    this.decreaseQuoteLevel(  );
}

Textarea.prototype.removeStrikethrough = function (  ) {
    
    this.command( 'changeFormat', null, { tag: 'STRIKE' } );
}

Textarea.prototype.replaceWith = function ( node, node2 ) {
    
    var parent = node.parentNode;
    
    if ( parent ) {
        parent.replaceChild( node2, node );
    }
}

Textarea.prototype.setTextareaSize = function ( value ) {
    
    console.log( 'Setting textarea size to ' + value + ' (not really)!' );
}

Textarea.prototype.setTypeSound = function ( value ) {
    
    console.log( 'Setting type sound to ' + value + ' (not really)!' );
}

Textarea.prototype.strikethrough = function (  ) {
    
    this.command( 'changeFormat', { tag: 'STRIKE' } );
}
