package com.elcom.ServerFilestorage.model

import java.sql.Timestamp
import javax.persistence.*

@Entity
@Table(name = "data_energy")
data class DataEnergy(
        @Id
        @GeneratedValue(strategy = GenerationType.AUTO)
        var id: Int = 0,
        @Column(name = "order_num")
        override var orderNum: Int = 0,
        @Column(name = "uid")
        override var UID: String = "",
        @Column(name = "id_train")
        override var idTrain: Int = 0,
        @Column(name = "car_number")
        override var idWagon: Int =0,
        @Column(name = "receiver_code")
        override var receiverCode: Int=0,
        @Column(name = "device_type")
        override var deviceId: Int=0,
        @Column(name = "command_type")
        override var commandType: Int=0,
        @Column(name = "time")
        override var timestamp: Timestamp = Timestamp(0),
        @Column(name = "time_received")
        override var timestampReceived: Timestamp = Timestamp(0),
        @Column(name = "amperage")
        val amperage: Int = 0,
        @Column(name = "voltage")
        val voltage: Int = 0,
        @Column(name = "energy_active")
        val energyActive: Int = 0,
        @Column(name = "energy_passive")
        val energyPassive: Int = 0
) : HeaderMeasure()