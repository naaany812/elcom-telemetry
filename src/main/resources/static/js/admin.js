var trains = [];
var currentDevices = [];
var headDevices = [];
var selectedTrain
$(document).ready(function () {
    $("#table_devices tbody tr").remove();
    $("#table_trains tbody tr").remove();
    bindSearchTable("#search_devices", "#counter_devices", "#table_devices")
    bindSearchTable("#search_trains", "#counter_trains", "#table_trains")
    refreshTrains();
    setListeners();
});

function refreshData() {
    refreshTrains();
    loadDevices(selectedTrain.systemId)

}

function refreshTrains() {
    $.getJSON("/api/systems",
        function (data) {
            window.trains = data
            var table = document.getElementById('table_trains').getElementsByTagName('tbody')[0];
            $("#table_trains tbody tr").remove();
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

                var cell2 = tr.insertCell()
                var newText2 = document.createTextNode(v.carCount)
                cell2.appendChild(newText2)

                var cell2 = tr.insertCell()
                var newText2 = document.createTextNode(v.systemId)
                cell2.appendChild(newText2)
            });
        }
    );
}

function loadDevices(id) {

    $.getJSON("api/devices?trainId=" + id,
        function (data) {
            window.currentDevices = data
            var table = document.getElementById('table_devices').getElementsByTagName('tbody')[0];
            $("#table_devices tbody tr").remove();
            var headDev = []
            // console.log(data.responseData.resultText)
            $.each(data, function (k, v) {
                //     console.log(k, v);
                // var keys = ["trainType", "trainNumber"];
                var tr = table.insertRow()
                var cell = tr.insertCell()
                var newText = document.createTextNode(v.carNumber)
                cell.appendChild(newText)

                if (v.deviceHwId == v.deviceHead) { headDev.push(v) }

                var text = ""

                switch (v.type) {
                    case "PG": text = "ПГ"; break;
                    case "MP": text = "МП"; break;
                    case "PP": text = "ПП"; break;
                }

                var cell2 = tr.insertCell()
                var newText2 = document.createTextNode(text)
                cell2.appendChild(newText2)

                var cell2 = tr.insertCell()
                var newText2 = document.createTextNode(v.deviceHwId)
                cell2.appendChild(newText2)

                var cell2 = tr.insertCell()
                var newText2 = document.createTextNode(v.name)
                cell2.appendChild(newText2)


                var cell2 = tr.insertCell()
                var newText2 = document.createTextNode(v.hwVer)
                cell2.appendChild(newText2)

                var cell2 = tr.insertCell()
                var newText2 = document.createTextNode(v.swVer)
                cell2.appendChild(newText2)
            });

            window.headDevices = headDev;
        }
    );
}

function sendJson(json, url) {
    var xhr = new XMLHttpRequest();
    xhr.open("POST", url, true);
    xhr.setRequestHeader("Content-Type", "application/json");
    xhr.send(json)
};

function setListeners() {

    $("#table_trains").on('click', 'tr', function (e) {
        var index = $(this).index()
        window.systemId = trains[index].systemId
        window.selectedTrain = trains[index]
        console.log(selectedTrain)
        $('#train_nameholder').html(selectedTrain.trainType + " " + selectedTrain.trainNumber)
        loadDevices(selectedTrain.systemId)
    });
    $("#table_devices").on('click', 'tr', function (e) {
        var index = $(this).index()
        console.log(currentDevices[index])
    });
    $("#button_save_train").on('click', function (e) {
        extractTrain()
        refreshTrains()
    });
    $("#checkbox_head").on('click', function (e) {
        check();
    });
    $("#modal_add_device").on('show.bs.modal', function () {
        loadHeadDevicesToList()
    });
}

function loadHeadDevicesToList() {

}

function addDevice() {
    if (selectedTrain != undefined) {

    }
    else {
        alert("Для добавления устройства выберите электропоезд!")
    }

}


function extractTrain() {
    var type = document.getElementById("train_type").value;
    var number = document.getElementById("train_number").value;
    var cars = parseInt(document.getElementById("train_car_count").value, 10);

    var code = ("" + type + number + "").hashCode()
    let train = {
        trainType: type,
        trainNumber: number,
        carCount: cars,
        systemId: code
    }
    console.log(train)
    if (typeof cars == 'number' && type != "" && number != "") {
        sendJson(JSON.stringify(train), "http://localhost:8080/api/add/systems")
        $('#modal_add_train').modal('hide');
    }
    else {
        var error = "Ошибка: \n"
        if (typeof cars != 'number')
            error = error + "количество вагонов не численный тип\n"

        if (type == "")
            error = error + "поле 'тип' - пустое\n"
        if (number == "")
            error = error + "поле 'номер' - пустое\n"

        alert(error)
    }
}

function check() {
    console.log(document.getElementById('checkbox_head').checked)
    document.getElementById('head_devices_modal_list').disabled = document.getElementById('checkbox_head').checked;
}

String.prototype.hashCode = function () {
    var hash = 0, i, chr;
    if (this.length === 0) return hash;
    for (i = 0; i < this.length; i++) {
        chr = this.charCodeAt(i);
        hash = ((hash << 5) - hash) + chr;
        hash |= 0; // Convert to 32bit integer
    }
    return hash;
};

function bindSearchTable(searchId, counterId, tableId) {
    $(searchId).keyup(function () {
        var searchTerm = $(searchId).val();
        var listItem = $(tableId + ' tbody').children('tr');
        var searchSplit = searchTerm.replace(/ /g, "'):containsi('")

        $.extend($.expr[':'], {
            'containsi': function (elem, i, match, array) {
                return (elem.textContent || elem.innerText || '').toLowerCase().indexOf((match[3] || "").toLowerCase()) >= 0;
            }
        });

        $(tableId + " tbody tr").not(":containsi('" + searchSplit + "')").each(function (e) {
            $(this).attr('visible', 'false');
        });

        $(tableId + " tbody tr:containsi('" + searchSplit + "')").each(function (e) {
            $(this).attr('visible', 'true');
        });

        var jobCount = $(tableId + ' tbody tr[visible="true"]').length;
        $(counterId).text('Найдено: ' + jobCount);

        if (jobCount == '0') { $('.no-result').show(); }
        else { $('.no-result').hide(); }
    });
};