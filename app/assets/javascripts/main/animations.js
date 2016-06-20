// fully complete one element's animations before starting the next element's 
// animations.
var animateInSequence = function ( selector, animations, durations ) {
    
    var $elements = $( selector );
    
    if ( $elements.length > 0 ) {
        animateNextElement( $elements, 0, animations, durations );
    }
}

// pause between the start of one element's animations and the start of the next 
// element's animations.
var animateWithPause = function ( selector, animations, durations, pause ) {
    
    var $elements = $( selector );
    
    if ( $elements.length > 0 ) {
        animateNextElementPause( $elements, 0, animations, durations, pause );
    }
}

var animateNextElementPause = function ( $elements, index, animations, durations, pause ) {
    
    if ( index < $elements.length ) {
        setTimeout( function (  ) {
            animateNextElementPause( $elements, index + 1, animations, durations, pause );
        }, pause );
    }
    
    if ( typeof( animations ) === 'function' && ( typeof( durations ) === 'number' || typeof( durations ) === 'string' ) ) {
        $( $elements[ index ] ).animate( animations, durations );
    } else if ( animations instanceof Array && durations instanceof Array ) {
        startNextAnimationPause( $elements[ index ], 0, animations, durations );
    }
}

var startNextAnimationPause = function ( element, index, animations, durations ) {
    
    $( element ).animate( animations[ index ], durations[ index ], function(  ) {
        if ( index < animations.length ) {
            startNextAnimationPause( element, index + 1, animations, durations );
        }
    } );
}

var animateNextElement = function ( $elements, index, animations, durations ) {
    
    if ( typeof( animations ) === 'function' && ( typeof( durations ) === 'number' || typeof( durations ) === 'string' ) ) {
        $( $elements[ index ] ).animate( animations, durations, function(  ) {
            if ( index < $elements.length ) {
                animateNextElement( $elements, index + 1, animations, durations );
            }
        } );
    } else if ( animations instanceof Array && durations instanceof Array ) {
        startNextAnimation( $elements, index, 0, animations, durations );
    }
}

var startNextAnimation = function ( $elements, elIndex, anIndex, animations, durations ) {
    
    $( $elements[ elIndex ] ).animate( animations[ anIndex ], durations[ anIndex ], function(  ) {
        if ( anIndex < animations.length ) {
            startNextAnimation( $elements, elIndex, anIndex + 1, animations, durations );
        } else if ( elIndex < $elements.length ) {
            animateNextElement( $elements, elIndex + 1, animations, durations );
        }
    } );
}
