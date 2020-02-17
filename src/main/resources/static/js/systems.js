$(document).ready(function () {
    buildTable();
}
);

function loadSystems() {
    var data = []
    $.ajax(
        {
            method: "GET",
            dataType: "json",
            url: "/api/systems",
            data: data
        }
    ).done(
        function (data) {
            var table = document.getElementById("systems_table")

            console.log(data)
            data.forEach(element => {
                var tr = table.insertRow(-1)

                console.log(element)

                for (var key in element) {
                    var cell = tr.insertCell(-1)

                    cell.innerHtml = element[key]
                    console.log(key + " " + element[key])
                }
                table.appendChild(tr)
            });
        }
    )

}

function buildTable() {
    var data = []
    $.ajax(
        {
            method: "GET",
            dataType: "json",
            url: "/api/systems",
            data: data
        }
    ).done(
        function (data) {
            var table = document.getElementById('systems_table').getElementsByTagName('tbody')[0];

            console.log(data)
            data.forEach(element => {
                var tr = table.insertRow()

                //  console.log(element)

                for (var key in element) {
                    if (key != "id") {
                        var cell = tr.insertCell()
                        var newText = document.createTextNode(element[key])
                        cell.appendChild(newText)
                    }
                    //    console.log(key + " " + element[key])

                }
            });

            // var row$ = $('<tr/>')
            // for (var key in element) {
            //     var cell = tr.insertCell(-1)

            //     cell.innerHtml = element[key]
            //     console.log(key + " " + element[key])
            // }

        }
    )
}