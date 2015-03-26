$( document ).ready( function(  ) {
    
    $( '.div-inkling-wrapper' ).each( function(  ) {
        var selectors = $( this ).data( 'selectors' );
        var $inkling = $( this ).children(  ).first(  );
        
        $inkling.find( '.leg-main' ).children(  ).css( 'visibility', 'visible' );
    
        for ( var i = 0; i < selectors.length; i++ ) {
            $inkling.find( '.' + selectors[ i ] ).children(  ).css( 'visibility', 'visible' );  
        }            
    } );
    
    $( '.moving' ).each( function(  ) {
        animateDiv( this.id );
    } );
} );

function animateDiv( targetid ) {
    
    var $target = $( '#' + targetid );
    var randomWait = ( Math.floor( Math.random(  ) * 8 ) + 2 ) * 1000;
    var newPosition = makeNewPosition( $target, $target.parent(  ) );
    var oldPosition = $target.position(  );
    var moveTime = calcMoveTime( [ oldPosition.top, oldPosition.left ], newPosition, $target );
       
    setTimeout( function(  ) {
        
        if ( newPosition[ 1 ] > oldPosition.left ) {
            $target.find( '.transform-group' ).attr( "transform", "translate(925, 0) scale(-1, 1)" );
        }
        else if ( newPosition[ 1 ] < oldPosition.left ) {
            $target.find( '.transform-group' ).attr( "transform", "scale(1, 1)" );
        }
        
        $target.find( '.leg-front-right' ).attr( 'class', 'leg-front-right stepping' );
        $target.find( '.leg-front-left' ).attr( 'class', 'leg-front-left stepping-opposite' );
        $target.find( '.leg-hind-left' ).attr( 'class', 'leg-hind-left stepping' );
        $target.find( '.leg-hind-right' ).attr( 'class', 'leg-hind-right stepping-opposite' );
    
        $( '#' + targetid ).animate( {
            top: newPosition[ 0 ],
            left: newPosition[ 1 ]
        }, moveTime, function(  ) {
            $target.find( '.leg-front-right' ).attr( 'class', 'leg-front-right to-rest' );
            $target.find( '.leg-front-left' ).attr( 'class', 'leg-front-left to-rest' );
            $target.find( '.leg-hind-left' ).attr( 'class', 'leg-hind-left to-rest' );
            $target.find( '.leg-hind-right' ).attr( 'class', 'leg-hind-right to-rest' );
            animateDiv( targetid );
        } );
    }, randomWait );
}

function calcMoveTime( prev, next, $target ) {

    var x = Math.abs( prev[ 1 ] - next[ 1 ]);
    var y = Math.abs( prev[ 0 ] - next[ 0 ] );
    
    // essentially: the target walks 50 pixels per second for every 
    // hundred pixels tall it is. Use this to calculate the time in
    // ms needed to travel the given distance.
    var distance = Math.sqrt( x * x + y * y );
    var speed = ( $target.height(  ) / 100 ) * 50;
    var time = Math.ceil( distance / speed ) * 1000;

    return( time );
}

function makeNewPosition( $target, $container ) {

    $container = ( $container || $( window ) );
    
    var height = $container.height(  ) - $target.height(  );
    var width = $container.width(  ) - $target.width(  );

    var newTop = Math.floor( Math.random(  ) * height );
    var newLeft = Math.floor( Math.random(  ) * width );
    
    var changeInTop = newTop - $target.position(  ).top;
    var changeInLeft = newLeft - $target.position(  ).left;
    
    if ( Math.abs( changeInTop ) > Math.abs( changeInLeft ) ) {
        // keep the original sign of the vertical position change, but
        // reduce its magnitude to that of the horizontal position
        // change. This is for looks; the animation is off otherwise.
        // note that the moving element will still remain in its container.
        newTop = $target.position(  ).top + ( ( changeInTop / Math.abs( changeInTop ) ) * Math.abs( changeInLeft ) );
    }

    return( [ newTop, newLeft ] );
}