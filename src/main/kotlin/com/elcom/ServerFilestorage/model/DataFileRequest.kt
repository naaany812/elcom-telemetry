package com.elcom.ServerFilestorage.model

import java.sql.Timestamp
import javax.persistence.Column
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.Id

data class DataFileRequest (
        var id: Int = 0,
        override var orderNum: Int = 0,
        override var UID: String = "",
        override var idTrain: Int = 0,
        override var idWagon: Int =0,
        override var receiverCode: Int=0,
        override var deviceId: String ="00",
        override var commandType: Int=0,
        override var timestamp: Timestamp = Timestamp(0),
        override var timestampReceived: Timestamp = Timestamp(0),
        var from:Int=0,
        var to:Int=0
) : HeaderMeasure()