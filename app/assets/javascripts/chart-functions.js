/*global $, document*/
function polar(observationData) {

    'use strict';
  
  
    // ------------------------------------------------------- //
    // Polar Chart
    // ------------------------------------------------------ //
    var POLARCHARTEXMPLE  = $('#polarChartExample');
    var polarChartExample = new Chart(POLARCHARTEXMPLE, {
        type: 'polarArea',
        options: {
            elements: {
                arc: {
                    borderWidth: 0,
                    borderColor: '#aaa'
                }
            }
        },
        data: {
            datasets: [{
                data: observationData,
                backgroundColor: [
                    "#e05f5f",
                    "#e96a6a",
                    "#ff7676",
                    "#ff8b8b",
                    "#fc9d9d"
                ],
                label: 'Teacher Overview' // for legend
            }],
            labels: [
                "Not Observed",
                "No Relation",
                "Shows Progress",
                "Meets Standard",
                "Exceeds Standard"
            ]
        }
    });

    var polarChartExample = {
        responsive: true
    };
  
};