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

    $.getJSON("/api/devices?trainId=" + id,
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
                if (v.deviceHwId)
                    var cell = tr.insertCell()
                var newText = document.createTextNode(v.carNumber)
                cell.appendChild(newText)

                if (v.deviceHwId == v.deviceHead) {
                    headDev.push(v)
                    tr.classList.add("table-primary")
                }

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
                var newText2 = document.createTextNode(v.deviceHead)
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
    $("#button_add_device").on('click', function (e) {
        if (selectedTrain != undefined) {
            $("#modal_add_device").modal('show');
        }
        else {
            alert("Для добавления устройства выберите электропоезд!");
        }
    });

    $("#button_save_device").on('click', function (e) {
        addDevice();
        loadDevices(selectedTrain.systemId);
    });
    $("#checkbox_head").on('click', function (e) {
        check();
    });
    $("#modal_add_device").on('show.bs.modal', function () {
        loadHeadDevicesToList();
    });
}

function loadHeadDevicesToList() {
    if (selectedTrain != undefined) {
        $.getJSON("/api/devices?trainId=" + selectedTrain.systemId + "&onlyHead=true",
            function (data) {
                window.headDevices = data
                var table = document.getElementById('table_trains').getElementsByTagName('tbody')[0];
                $("#head_devices_modal_list option").remove();
                // console.log(data.responseData.resultText)
                var select = document.getElementById("head_devices_modal_list")
                $.each(data, function (k, v) {
                    //     console.log(k, v);
                    // var keys = ["trainType", "trainNumber"];
                    var tr = "(" + v.carNumber + ") " + v.deviceHwId
                    var option = document.createElement("option")
                    option.label = tr
                    option.value = "" + v.deviceHwId
                    select.add(option)
                });
            }

        );
    }
    else {
        alert("Для добавления устройства выберите электропоезд!")
    }
}

function addDevice() {
    if (selectedTrain != undefined) {
        var deviceHwId = parseInt(document.getElementById("text_device_id").value, 10);
        var deviceHead = deviceHwId

        if (!document.getElementById('checkbox_head').checked) {
            var select = document.getElementById("head_devices_modal_list")
            deviceHead = parseInt(select.value, 10)
        }
        var carNumber = parseInt(document.getElementById("text_car_number").value, 10);
        var type = document.getElementById("select_car_types").value
        var name = document.getElementById("select_device_types").value
        var tid = selectedTrain.systemId
        let device =
        {
            deviceHwId: deviceHwId,
            deviceHead: deviceHead,
            carNumber: carNumber,
            type: type,
            name: name,
            trainId: tid
        }
        if (carNumber <= selectedTrain.carCount) {
            console.log(device)
            sendJson(JSON.stringify(device), "/api/add/devices")
            $('#modal_add_device').modal('hide');
        }
        else {
            var error = "Ошибка: \n"
            if (typeof deviceHwId != 'number')
                error = error + "идентификатор не численный тип\n"
            if (typeof deviceHead != 'number')
                error = error + "идентификатор головного устройства не численный тип\n"
            if (carNumber > selectedTrain.carCount)
                error = error + "номер вагона превышает допустимый\n"

            alert(error)
        }
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
        sendJson(JSON.stringify(train), "/api/add/systems")
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