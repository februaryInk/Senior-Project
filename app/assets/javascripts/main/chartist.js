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
    
    chart = new Chartist.Line( '.ct-chart', 
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
            showArea: false,
            showLine: true,
            showPoint: false
        } 
    );
}
