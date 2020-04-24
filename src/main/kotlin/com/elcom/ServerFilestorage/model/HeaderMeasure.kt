package com.elcom.ServerFilestorage.model

import java.sql.Timestamp

open class HeaderMeasure(
        open var orderNum: Int = 0,
        open var UID: String = "",
        open var idTrain: Int = 0,
        open var idWagon: Int =0,
        open var receiverCode: Int = 0,
        open var deviceId: Int =0,
        open var commandType: Int=0,
        open var timestamp: Timestamp=Timestamp(0),
        open var timestampReceived: Timestamp=Timestamp(0)
)