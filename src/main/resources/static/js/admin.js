var trains = [];
var currentDevices = [];
var headDevices = [];
var files = [];
var selectedTrain
var selectedFile
var selectedDevice
$(document).ready(function () {
    var yesterday = new Date()
    var tomorrow = new Date(yesterday)
    yesterday.setDate(yesterday.getDate() - 1)
    tomorrow.setDate(tomorrow.getDate() + 1)
    var endt = dateFormat(tomorrow, 'm/d/Y')
    var startt = dateFormat(yesterday, 'm/d/Y')
    console.log(startt + " " + endt)

    /*   $(function () {
          var start = moment().add(1, 'day').endOf('day');
          var end = moment().add(1, 'day').endOf('day');
          function cb(start, end) {
              $('#reportrange span').html(start.format('MMM D') + ' - ' + end.format('MMM D'));
          }
          $('#reportrange').daterangepicker({
              startDate: start,
              endDate: end
          }, cb);
          cb(start, end);
      });
  
      $('input[name="reportRange"]').daterangepicker({
          timePicker: true,
          startDate: moment().startOf('hour'),
          endDate: moment().startOf('hour').add(32, 'hour'),
          locale: {
            format: 'M/DD hh:mm A'
          }
        }); */
    $('#reportrange').daterangepicker({
        "linkedCalendars": false,
        "showCustomRangeLabel": false,
        "startDate": startt,
        "endDate": endt,
        locale: {
            format: 'MM/DD/YYYY'
        }
    }, function (start, end, label) {
        $("#table_climate tbody tr").remove();
        $("#table_energy tbody tr").remove();
        console.log("applyed")
        loadEnergy(start.format('YYYY-MM-DD'), end.format('YYYY-MM-DD'), selectedDevice.deviceHwId)
        loadClimate(start.format('YYYY-MM-DD'), end.format('YYYY-MM-DD'), selectedDevice.deviceHwId)

    });
    /*     $('#reportrange').on('apply.daterangepicker', function(ev, picker) {
            alert ('hello');
        }); */
    $("#table_devices tbody tr").remove();
    $("#table_trains tbody tr").remove();
    bindSearchTable("#search_devices", "#counter_devices", "#table_devices")
    bindSearchTable("#search_trains", "#counter_trains", "#table_trains")
    refreshTrains();
    loadSoftwareToElements();
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

function loadClimate(start, end, deviceUid) {
    $("#table_climate tbody tr").remove();
    $.getJSON("/api/climate?startDate=" + start + "&endDate=" + end + "&deviceUid=" + deviceUid + "",
        function (data) {
            var table = document.getElementById('table_climate').getElementsByTagName('tbody')[0];
            var mapClimate = {}
            var mapPower = {}
            var mapColor = {}
            var cntr = 1
            // console.log(data.responseData.resultText)
            $.each(data, function (k, v) {
                console.log(k, v);
                cntr = cntr + 1
                var tr = table.insertRow()
                var cell = tr.insertCell()
                var newText = document.createTextNode(dateFormat(new Date(v.timestamp), 'd-m-Y h:i:s'))
                cell.appendChild(newText)

                var cell2 = tr.insertCell()
                var newText2 = document.createTextNode(v.channel1)
                cell2.appendChild(newText2)
                var cell2 = tr.insertCell()
                var newText2 = document.createTextNode(v.channel2)
                cell2.appendChild(newText2)
                var cell2 = tr.insertCell()
                var newText2 = document.createTextNode(v.channel3)
                cell2.appendChild(newText2)
                var cell2 = tr.insertCell()
                var newText2 = document.createTextNode(v.channel4)
                cell2.appendChild(newText2)
            });

            //     buildCharts(mapClimate, mapPower, mapColor)
        }
    );
}

function loadEnergy(start, end, deviceUid) {
    $("#table_energy tbody tr").remove();
    $.getJSON("/api/energy?startDate=" + start + "&endDate=" + end + "&deviceUid=" + deviceUid + "",
        function (data) {
            var table = document.getElementById('table_energy').getElementsByTagName('tbody')[0];
            var mapClimate = {}
            var mapPower = {}
            var mapColor = {}
            var cntr = 1
            // console.log(data.responseData.resultText)
            $.each(data, function (k, v) {
                console.log(k, v);
                // var keys = ["trainType", "trainNumber"];
                cntr = cntr + 1
                var tr = table.insertRow()
                var cell = tr.insertCell()
                var newText = document.createTextNode(dateFormat(new Date(v.timestamp), 'd-m-Y h:i:s'))
                cell.appendChild(newText)

                var cell2 = tr.insertCell()
                var newText2 = document.createTextNode(v.amperage)
                cell2.appendChild(newText2)
                var cell2 = tr.insertCell()
                var newText2 = document.createTextNode(v.voltage)
                cell2.appendChild(newText2)
                var cell2 = tr.insertCell()
                var newText2 = document.createTextNode(v.energyActive)
                cell2.appendChild(newText2)
                var cell2 = tr.insertCell()
                var newText2 = document.createTextNode(v.energyPassive)
                cell2.appendChild(newText2)
            });

            //     buildCharts(mapClimate, mapPower, mapColor)
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
                var btn = document.createElement("BUTTON")
                btn.innerHTML = "<a onClick='routeToMeasures(" + (tr.rowIndex - 1) + ");'>" +
                    v.deviceHwId +
                    "</a>"
                cell2.appendChild(btn);

                //  var newText2 = document.createTextNode(v.swVer)
                console.log("Index: " + tr.rowIndex)
                console.log("Index: " + tr)
                var cell2 = tr.insertCell()
                var btn = document.createElement("BUTTON")
                btn.innerHTML = "<a onClick='editSoftware(" + (tr.rowIndex - 1) + ");'>" +
                    v.swVer +
                    "</button>"
                cell2.appendChild(btn);

                var cell2 = tr.insertCell()
                var newText2 = document.createTextNode(v.hwVer)
                cell2.appendChild(newText2)

                var text="Нет"
                if(v.update)
                text="Да"
                var cell2 = tr.insertCell()
                var newText2 = document.createTextNode(text)
                cell2.appendChild(newText2)

            });

            window.headDevices = headDev;
        }
    );
}
function createElementFromHTML(htmlString) {
    var div = document.createElement('div');
    div.innerHTML = htmlString.trim();

    // Change this to div.childNodes to support multiple top-level nodes
    return div.firstChild;
}
function editSoftware(index) {
    selectedFile = files[index]
    selectedDevice=currentDevices[index]
    if (selectedFile != undefined) {
        $("#modal_update_software").modal('show');
    }
    else {
        alert("Для обновления загрузите прошивки!");
    }
    //  var index = $(this).index();
    //  routeToMeasures(index);
    console.log("yahooo")
}
function sendJson(json, url) {
    var xhr = new XMLHttpRequest();
    xhr.open("POST", url, true);
    xhr.setRequestHeader("Content-Type", "application/json");
    xhr.send(json)
};

function setListeners() {

    $('#upload_form').submit(function (event) {
        var formElement = this;
        // You can directly create form data from the form element
        // (Or you could get the files from input element and append them to FormData as we did in vanilla javascript)
        var formData = new FormData(formElement);
        
        var swVer = parseInt(document.getElementById("version_input").value, 10);
        formData.append('version', swVer)
        // formData.append(formElement)
        console.log(formData)
        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "/api/uploadFile",
            data: formData,
            processData: false,
            contentType: false,
            success: function (response) {
                console.log(response);
                loadSoftwareToElements();
                // process response
            },
            error: function (error) {
                console.log(error);
                // process error
            }
        });

        event.preventDefault();
    });

    $("#table_trains").on('click', 'tr', function (e) {
        var index = $(this).index()
        window.systemId = trains[index].systemId
        window.selectedTrain = trains[index]
        console.log(selectedTrain)
        $('#train_nameholder').html(selectedTrain.trainType + " " + selectedTrain.trainNumber)
        loadDevices(selectedTrain.systemId)
    });

    // $("#table_devices").on('click', 'tr', function (e) {
    //     var index = $(this).index();
    //     routeToMeasures(index);
    // });
    $("#button_save_train").on('click', function (e) {
        extractTrain()
        refreshTrains()
        location.reload()
    });

    $("#button_update_file").on('click', function (e) {
        updateFile()
        loadDevices(selectedTrain.systemId);
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
        location.reload();
    });
    $("#checkbox_head").on('click', function (e) {
        check();
    });
    $("#modal_add_device").on('show.bs.modal', function () {
        loadHeadDevicesToList();
    });
}
function updateFile() {
    var select = document.getElementById("software_modal_list")
    var fileID = parseInt(select.value, 10)
    console.log(fileID)
    var uid = selectedDevice.deviceHwId
    $.getJSON("/api/setFile?uid=" + uid + "&fileId=" + fileID,
        function (data) {
            console.log(data);
            $("#modal_add_device").modal('hide');
        });
}
function routeToMeasures(index) {
    $("#table_climate tbody tr").remove();
    $("#table_energy tbody tr").remove();
    selectedDevice = currentDevices[index]
    $('.nav-tabs a[href="#tab-2"]').tab('show')
    console.log(currentDevices[index])
    $('#device_nameholder').html(selectedDevice.deviceHwId)
    var yesterday = new Date()
    var tomorrow = new Date(yesterday)
    yesterday.setDate(yesterday.getDate() - 1)
    tomorrow.setDate(tomorrow.getDate() + 1)
    var end = dateFormat(tomorrow, 'Y-m-d')
    var start = dateFormat(yesterday, 'Y-m-d')

    $('#reportrange').data('daterangepicker').setStartDate(dateFormat(yesterday, 'm/d/Y'));
    $('#reportrange').data('daterangepicker').setEndDate(dateFormat(tomorrow, 'm/d/Y'));
    loadClimate(start, end, selectedDevice.deviceHwId)
    loadEnergy(start, end, selectedDevice.deviceHwId)
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

function loadSoftwareToElements() {
    $.getJSON("/api/files",
        function (data) {
            window.files = data
            var table = document.getElementById('table_software').getElementsByTagName('tbody')[0];
            $("#software_modal_list option").remove();
            $("#table_software tbody tr").remove();
            // console.log(data.responseData.resultText)
            var select = document.getElementById("software_modal_list")
            $.each(data, function (k, v) {
                //     console.log(k, v);
                // var keys = ["trainType", "trainNumber"];
                //  files.add()
                var tr = "" + v.name + " " + "v." + v.version
                var option = document.createElement("option")
                option.label = tr
                option.value = "" + v.id
                select.add(option)

                var tr = table.insertRow()
                var cell = tr.insertCell()
                var newText = document.createTextNode(v.name)
                cell.appendChild(newText)

                var cell = tr.insertCell()
                var newText = document.createTextNode("v."+v.version)
                cell.appendChild(newText)

                var cell = tr.insertCell()
                var newText = document.createTextNode(v.size+"B")
                cell.appendChild(newText)
            });
        }

    );
}

function updateSoftware() {

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

