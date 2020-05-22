package com.elcom.ServerFilestorage.model

import java.sql.Timestamp
import javax.persistence.*

@Entity
@Table(name = "data_rssi")
data class DataRadio(
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
        override var deviceId: String ="00",
        @Column(name = "command_type")
        override var commandType: Int=0,
        @Column(name = "time")
        override var timestamp: Timestamp = Timestamp(0),
        @Column(name = "time_received")
        override var timestampReceived: Timestamp = Timestamp(0),
        @Column(name = "rssi")
        val rssi: Int=0,
        @Column(name = "rssi_reverse")
        val rssiReverse: Int=0,
        @Column(name = "received_count")
        val receivedCount: Long = 0,
        @Column(name = "total_count")
        val totalCount: Long = 0
) : HeaderMeasure()