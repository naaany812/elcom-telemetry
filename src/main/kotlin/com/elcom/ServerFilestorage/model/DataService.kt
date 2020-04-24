package com.elcom.ServerFilestorage.model

import java.sql.Timestamp
import javax.persistence.Column
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.Id

data class DataService(
        @Id
        @GeneratedValue(strategy = GenerationType.AUTO)
        var id: Int = 0,
        @Column(name = "order_num")
        override var orderNum: Int = 0,
        @Column(name = "uid")
        override var UID: String = "",
        @Column(name = "id_train")
        override var idTrain: Int = 0,
        @Column(name = "car_num")
        override var idWagon: Int =0,
        @Column(name = "receiver_code")
        override var receiverCode: Int=0,
        @Column(name = "device_id")
        override var deviceId: Int=0,
        @Column(name = "command_type")
        override var commandType: Int=0,
        @Column(name = "time")
        override var timestamp: Timestamp = Timestamp(0),
        @Column(name = "time_received")
        override var timestampReceived: Timestamp = Timestamp(0),
        val swVer:Int=0,
        val hwVer:Int=0,
        val phone:Int=0,
        val balance:Int=0,
        val enableTime: Int=0,
        val disableTime: Int=0
) : HeaderMeasure()