function line() {

    'use strict';
  
    // ------------------------------------------------------- //
    // Charts Gradients
    // ------------------------------------------------------ //
    var ctx1 = $("canvas").get(0).getContext("2d");
    var gradient1 = ctx1.createLinearGradient(150, 0, 150, 300);
    gradient1.addColorStop(0, 'rgba(133, 180, 242, 0.91)');
    gradient1.addColorStop(1, 'rgba(255, 119, 119, 0.94)');

    var gradient2 = ctx1.createLinearGradient(146.000, 0.000, 154.000, 300.000);
    gradient2.addColorStop(0, 'rgba(104, 179, 112, 0.85)');
    gradient2.addColorStop(1, 'rgba(76, 162, 205, 0.85)');
  
  
    // ------------------------------------------------------- //
    // Line Chart
    // ------------------------------------------------------ //
    var LINECHARTEXMPLE   = $('#lineChartExample');
    var lineChartExample = new Chart(LINECHARTEXMPLE, {
        type: 'line',
        options: {
            legend: {labels:{fontColor:"#777", fontSize: 12}},
            scales: {
                xAxes: [{
                    display: true,
                    gridLines: {
                        color: '#eee'
                    }
                }],
                yAxes: [{
                    display: true,
                    gridLines: {
                        color: '#eee'
                    }
                }]
            },
        },
        data: {
            labels: ["January", "February", "March", "April", "May", "June", "July"],
            datasets: [
                {
                    label: "Data Set One",
                    fill: true,
                    lineTension: 0.3,
                    backgroundColor: gradient1,
                    borderColor: gradient1,
                    borderCapStyle: 'butt',
                    borderDash: [],
                    borderDashOffset: 0.0,
                    borderJoinStyle: 'miter',
                    borderWidth: 1,
                    pointBorderColor: gradient1,
                    pointBackgroundColor: "#fff",
                    pointBorderWidth: 1,
                    pointHoverRadius: 5,
                    pointHoverBackgroundColor: gradient1,
                    pointHoverBorderColor: "rgba(220,220,220,1)",
                    pointHoverBorderWidth: 2,
                    pointRadius: 1,
                    pointHitRadius: 10,
                    data: [30, 50, 40, 61, 42, 35, 40],
                    spanGaps: false
                },
                {
                    label: "Data Set Two",
                    fill: true,
                    lineTension: 0.3,
                    backgroundColor: gradient2,
                    borderColor: gradient2,
                    borderCapStyle: 'butt',
                    borderDash: [],
                    borderDashOffset: 0.0,
                    borderJoinStyle: 'miter',
                    borderWidth: 1,
                    pointBorderColor: gradient2,
                    pointBackgroundColor: "#fff",
                    pointBorderWidth: 1,
                    pointHoverRadius: 5,
                    pointHoverBackgroundColor: gradient2,
                    pointHoverBorderColor: "rgba(220,220,220,1)",
                    pointHoverBorderWidth: 2,
                    pointRadius: 1,
                    pointHitRadius: 10,
                    data: [50, 40, 50, 40, 45, 40, 30],
                    spanGaps: false
                }
            ]
        }
    });
  
    var lineChartExample = {
        responsive: true
    };
    
};


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
                    "rgba(106, 198, 197, .8)",
                    "rgba(81, 173, 172, .8)",
                    "rgba(55, 147, 146, .8)",
                    "rgba(30, 122, 121, .8)",
                    "rgba(4, 96, 95, .8)"
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

function bar() {

    'use strict';
  
    // ------------------------------------------------------- //
    // Bar Chart 1
    // ------------------------------------------------------ //
    var BARCHART1 = $('#barChart1');
    var barChartHome = new Chart(BARCHART1, {
        type: 'bar',
        options:
        {
            scales:
            {
                xAxes: [{
                    display: true,
                    gridLines: {
                        color: '#eee'
                    }
                }],
                yAxes: [{
                    display: true,
                    gridLines: {
                        color: '#eee'
                    }
                }]
            },
            legend: {
                display: true
            }
        },
        data: {
            labels: [
                "Not Observed",
                "No Relation",
                "Shows Progress",
                "Meets Standard",
                "Exceeds Standard"
            ],
            datasets: [
                {
                    label: "Plan",
                    backgroundColor: [
                        '#44b2d7',
                        '#44b2d7',
                        '#44b2d7',
                        '#44b2d7',
                        '#44b2d7'
                    ],
                    borderColor: [
                        '#44b2d7',
                        '#44b2d7',
                        '#44b2d7',
                        '#44b2d7',
                        '#44b2d7'
                    ],
                    borderWidth: 0,
                    data: [35, 55, 65, 85, 30]
                },
                {
                    label: "Presentation",
                    backgroundColor: [
                        '#59c2e6',
                        '#59c2e6',
                        '#59c2e6',
                        '#59c2e6',
                        '#59c2e6'
                    ],
                    borderColor: [
                        '#59c2e6',
                        '#59c2e6',
                        '#59c2e6',
                        '#59c2e6',
                        '#59c2e6'
                    ],
                    borderWidth: 0,
                    data: [49, 68, 85, 40, 27]
                },
                {
                    label: "Activity",
                    backgroundColor: [
                        '#59c2e6',
                        '#59c2e6',
                        '#59c2e6',
                        '#59c2e6',
                        '#59c2e6'
                    ],
                    borderColor: [
                        '#59c2e6',
                        '#59c2e6',
                        '#59c2e6',
                        '#59c2e6',
                        '#59c2e6'
                    ],
                    borderWidth: 0,
                    data: [49, 68, 85, 40, 27]
                },
                {
                    label: "Assessment",
                    backgroundColor: [
                        '#59c2e6',
                        '#59c2e6',
                        '#59c2e6',
                        '#59c2e6',
                        '#59c2e6'
                    ],
                    borderColor: [
                        '#59c2e6',
                        '#59c2e6',
                        '#59c2e6',
                        '#59c2e6',
                        '#59c2e6'
                    ],
                    borderWidth: 0,
                    data: [49, 68, 85, 40, 27]
                },
                {
                    label: "Climate",
                    backgroundColor: [
                        '#59c2e6',
                        '#59c2e6',
                        '#59c2e6',
                        '#59c2e6',
                        '#59c2e6'
                    ],
                    borderColor: [
                        '#59c2e6',
                        '#59c2e6',
                        '#59c2e6',
                        '#59c2e6',
                        '#59c2e6'
                    ],
                    borderWidth: 0,
                    data: [49, 68, 85, 40, 27]
                }
            ]
        }
    });
  
    var barChartHome = {
        responsive: true
    };
};
