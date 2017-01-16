var chart, data, res, userId;

$( document ).ready( function (  ) {
    
    userId = $( '.ct-chart' ).data( 'user-id' );
    
    $.ajax( {
        url: '/users/' + userId.toString(  ) + '/progress',
        type: 'get',
        dataType: 'json',
        success: function ( response ) {
            constructChart( '.ct-chart', response );
        },
        error: function ( response ) {
            console.log( 'Failure to launch.' );
            res = response;
        }
    } );
} );

constructChart = function ( selector, series ) {
    
    var seriesData = [  ];
    
    for ( var key in series ) {
        if ( series.hasOwnProperty( key ) ) {
            seriesData.push( {
                name: key,
                color: '#444444',
                data: series[ key ]
            } );
        }
    }
    
    var progressChart = new Chartist.Line( '.ct-chart', 
        {
            series: seriesData
        }, 
        {
            axisX: {
                type: Chartist.FixedScaleAxis,
                divisor: 30,
                labelInterpolationFnc: function ( value ) {
                    return moment( value * 1000 ).format( 'MMM Do' );
                }
            },
            axisY: {
                position: 'right'
            },
            showArea: true,
            showLine: true,
            showPoint: false
        } 
    );
    
    var defs = document.createElement('defs');
    var filter = document.createElementNS('http://www.w3.org/2000/svg', 'filter');
    var turbulence = document.createElementNS("http://www.w3.org/2000/svg", 'feTurbulence');
    var colorMatrix = document.createElementNS("http://www.w3.org/2000/svg", 'feColorMatrix');
    var composite = document.createElementNS("http://www.w3.org/2000/svg", 'feComposite');
    
    filter.setAttribute('id', 'alcohol-ink');
    
    turbulence.setAttribute('baseFrequency', '0.02, 0.01')
    turbulence.setAttribute('height', '100%')
    turbulence.setAttribute('numOctaves', '4')
    turbulence.setAttribute('result', 'FRACTAL-TEXTURE-10')
    turbulence.setAttribute('seed', '0')
    turbulence.setAttribute('type', 'fractalNoise')
    turbulence.setAttribute('width', '100%')
    turbulence.setAttribute('height', '100%');
    
    colorMatrix.setAttribute('in', 'FRACTAL-TEXTURE-10')
    colorMatrix.setAttribute('result', 'FRACTAL-TEXTURE-20')
    colorMatrix.setAttribute('type', 'matrix')
    colorMatrix.setAttribute('values', '0 0 0 0 0, 0 0 0 0 0, 0 0 0 0 0, 0 0 0 -1.2 1.1');
    
    composite.setAttribute('in', 'SourceGraphic')
    composite.setAttribute('in2', 'FRACTAL-TEXTURE-20')
    composite.setAttribute('operator', 'in');
    composite.setAttribute('result', 'FRACTAL-TEXTURE-30');
    
    defs.appendChild( filter );
    
    setTimeout( function (  ) {
        progressChart.svg._node.setAttribute( 'xmlns', "http://www.w3.org/2000/svg" );
        progressChart.svg._node.setAttribute( 'xmlns:xlink', "http://www.w3.org/1999/xlink" );
        progressChart.svg._node.insertBefore( filter, progressChart.svg._node.firstChild );
        
        filter.appendChild( turbulence );
        filter.appendChild( colorMatrix );
        filter.appendChild( composite );
        
        $( '.ct-area' ).attr( 'filter', 'url(#alcohol-ink)' );
    }, 1000 );
}
