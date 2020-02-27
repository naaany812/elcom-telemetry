var measures = [];
var trains = [];
var dateFrom
var dateTo
var systemId = 0
var selectedTrain
Colors = {};
Colors.names = {
    aqua: "#00ffff",
    black: "#000000",
    blue: "#0000ff",
    brown: "#a52a2a",
    cyan: "#00ffff",
    darkblue: "#00008b",
    darkcyan: "#008b8b",
    darkgrey: "#a9a9a9",
    darkgreen: "#006400",
    darkkhaki: "#bdb76b",
    darkmagenta: "#8b008b",
    darkolivegreen: "#556b2f",
    darkorange: "#ff8c00",
    darkorchid: "#9932cc",
    darkred: "#8b0000",
    darksalmon: "#e9967a",
    darkviolet: "#9400d3",
    fuchsia: "#ff00ff",
    gold: "#ffd700",
    green: "#008000",
    indigo: "#4b0082",
    lightgreen: "#90ee90",
    lightpink: "#ffb6c1",
    lime: "#00ff00",
    magenta: "#ff00ff",
    maroon: "#800000",
    navy: "#000080",
    olive: "#808000",
    orange: "#ffa500",
    pink: "#ffc0cb",
    purple: "#800080",
    violet: "#800080",
    red: "#ff0000",
    silver: "#c0c0c0",
    yellow: "#ffff00"
};
Colors.random = function() {
    var result;
    var count = 0;
    for (var prop in this.names)
        if (Math.random() < 1/++count)
           result = prop;
    return result;
};
$(document).ready(function () {
    $("#table_modal").on('click', 'tr', function (e) {
        var index = $(this).index()
        window.systemId = trains[index].systemId
        console.log(index)
        console.log(trains[index].systemId)
        $('#train_nameholder').html(trains[index].trainType + " " + trains[index].trainNumber)
        $('#modal_select').modal('hide')
    });
    //  buildTable();
    $('#reportrange').daterangepicker({
    "linkedCalendars": false,
    "showCustomRangeLabel": false,
    "startDate": "02/14/2020",
    "endDate": "02/20/2020"
    }, function (start, end, label) {
        $("#table_measures_content tbody tr").remove();
        console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')');
        $.getJSON("/api/measures?startDate=" + start.format('YYYY-MM-DD') + "&endDate=" + end.format('YYYY-MM-DD') + "&systemId=" + window.systemId + "",
            function (data) {
                var table = document.getElementById('table_measures_content').getElementsByTagName('tbody')[0];
                var mapClimate = {}
                var mapPower = {}
                var mapColor = {}
                var cntr = 1
                // console.log(data.responseData.resultText)
                $.each(data, function (k, v) {
                    console.log(k, v);
                    // var keys = ["trainType", "trainNumber"];

                    if (!(v.deviceId in mapClimate)) {
                        mapClimate[v.deviceId] = []
                    }
                    if (!(v.deviceId in mapPower)) {
                        mapPower[v.deviceId] = []
                    }
                    mapColor[v.deviceId] = Colors.random()
                    
                
                    console.log(v.date)
                    var date = new Date(+v.date)
                    console.log(date)
                    var dateStr = date.getFullYear() + '-' + (date.getMonth() + 1).toString().padStart(2, "0") + '-' + date.getDate() + 'T' + v.time
                    date = new Date(dateStr)
                    console.log(dateStr)
                    console.log(date)
                    mapClimate[v.deviceId].push({ x: date, y: v.temperature })
                    mapPower[v.deviceId].push({ x: date, y: v.wattage })
                    cntr = cntr + 1
                    var tr = table.insertRow()
                    var cell = tr.insertCell()
                    var newText = document.createTextNode(v.deviceId)
                    cell.appendChild(newText)

                    var cell2 = tr.insertCell()
                    var newText2 = document.createTextNode(v.time)
                    cell2.appendChild(newText2)

                    var cell3 = tr.insertCell()
                    var newText3 = document.createTextNode(v.coordinates)
                    cell3.appendChild(newText3)

                    var cell4 = tr.insertCell()
                    var newText4 = document.createTextNode(v.temperature)
                    cell4.appendChild(newText4)

                    var cell5 = tr.insertCell()
                    var newText5 = document.createTextNode(v.wattage)
                    cell5.appendChild(newText5)
                });

                buildCharts(mapClimate, mapPower,mapColor)
            }
        );
    });
    buildTableSystems();

}
);

function buildCharts(climate, power,colors) {
    //  var ctx = document.getElementById('chart_climate').getContext('2d')//.chart
    console.log(climate)
    console.log(power)
    var ctx = $('canvas').eq(0)
    var chartClimate = new Chart(ctx, {
        type: 'line',
        data: {
            labels: [],
            datasets: []
        },
        options: {
            scales: {
                xAxes: [{
                    type: 'time',
                    position: 'bottom',
                    displayFormats: {
                        'millisecond': 'MMM DD',
                        'second': 'MMM DD',
                        'minute': 'MMM DD',
                        'hour': 'MMM DD',
                        'day': 'MMM DD',
                        'week': 'MMM DD',
                        'month': 'MMM DD',
                        'quarter': 'MMM DD',
                        'year': 'MMM DD',
                    }
                }]
            }
        }
    })

    $.each(climate, function (k, v) {
        var dataset = { label: k, data: v, fill: false, backgroundColor: colors[k], borderColor: colors[k] }
        console.log(k)
        // chartClimate["data"]["labels"].push(k)
        chartClimate.data.datasets.push(dataset)//["datasets"].push(dataset)
        chartClimate.update()
    }
    );
    var ctx = $('canvas').eq(1)
    var chartPower = new Chart(ctx, {
        type: 'line',
        data: {
            labels: [],
            datasets: []
        },
        options: {
            scales: {
                xAxes: [{
                    type: 'time',
                    position: 'bottom',
                    displayFormats: {
                        'millisecond': 'MMM DD',
                        'second': 'MMM DD',
                        'minute': 'MMM DD',
                        'hour': 'MMM DD',
                        'day': 'MMM DD',
                        'week': 'MMM DD',
                        'month': 'MMM DD',
                        'quarter': 'MMM DD',
                        'year': 'MMM DD',
                    }
                }]
            }
        }
    })
    $.each(power, function (k, v) {
        var dataset = { label: k, data: v, fill: false, backgroundColor: colors[k], borderColor: colors[k] }
        console.log(k)
        // chartClimate["data"]["labels"].push(k)
        chartPower.data.datasets.push(dataset)//["datasets"].push(dataset)
        chartPower.update()
    }
    );

};


function buildTable() {
    var data = []
    $.ajax(
        {
            method: "GET",
            dataType: "json",
            url: "/api/measures",
            data: data
        }
    ).done(
        function (data) {
            var table = document.getElementById('table_measures_content').getElementsByTagName('tbody')[0];

            //   console.log(data)
            var keys = ['deviceId', 'date', 'coordinates', 'temperature', 'wattage']
            data.forEach(element => {

                var tr = table.insertRow()
                for (var key in keys) {
                    var cell = tr.insertCell()
                    var newText = document.createTextNode(element[key])
                    cell.appendChild(newText)
                }
                //       console.log(element)
            });

        }
    )
}

function buildTableSystems() {
    var data = []
    /*fetch("http://localhost:8080/api/systems").then(function (response) {
        return response.json();
    }).then(function (data) {
        console.log(data);
        var table = document.getElementById('table_modal').getElementsByTagName('tbody')[0];

        // console.log(data)
        var keys = ['trainType', 'trainNumber'];
        data.forEach(element => {

            var tr = table.insertRow()
            for (var key in keys) {

                var cell = tr.insertCell()
                var newText = document.createTextNode(element.key)
                cell.appendChild(newText)
              //  console.log(element)
            }
        });
    }); */
    /*$.ajax(
        {
            method: "GET",
            dataType: "json",
            url: "/api/systems",
            data: data
        }
    ).done(function (data) {
        var table = document.getElementById('table_modal').getElementsByTagName('tbody')[0];

        var keys = ['trainType', 'trainNumber'];
        data.forEach(element => function (element) {
            var tr = table.insertRow()

            for (var key in keys) {
                var cell = tr.insertCell()
                var newText = document.createTextNode(element[key])
                cell.appendChild(newText)
            }
        });
    }); */
    $.getJSON("/api/systems",
        function (data) {
            window.trains = data
            var table = document.getElementById('table_modal').getElementsByTagName('tbody')[0];
            // console.log(data.responseData.resultText)
            $.each(data, function (k, v) {
                //     console.log(k, v);
                // var keys = ["trainType", "trainNumber"];
                var tr = table.insertRow()
                var cell = tr.insertCell()
                var newText = document.createTextNode(v.trainType)
                cell.appendChild(newText)
                var cell2 = tr.insertCell()
                var newText2 = document.createTextNode(v.trainNumber)
                cell2.appendChild(newText2)
            });
        }
    );
}