package com.elcom.ServerFilestorage.model


import java.sql.Time
import java.sql.Date
import java.util.*
import javax.persistence.*

@Entity
@Table(name = "measures")
data class Measure
(
        @Id
        @GeneratedValue(strategy = GenerationType.AUTO)
        val id: Int = -1,
        @Column(name = "device_hw_id")
        val deviceId: Int,
        @Column(name = "system_id")
        val systemId: Int,
        @Column(name = "coordinates")
        val coordinates: String,
        @Column(name = "date")
        var date: Date?,
        @Column(name = "time_day")
        var time: Time?,
        val dateGSM: String,
        val timeGSM: String,
        @Column(name = "rssi")
        val rssi: Int,
        @Column(name = "temp1")
        val temp1: Double?,
        @Column(name = "temp2")
        val temp2: Double?,
        @Column(name = "temp3")
        val temp3: Double?,
        @Column(name = "temp4")
        val temp4: Double?,
        @Column(name = "temp5")
        val temp5: Double?,
        @Column(name = "voltage")
        val voltage: Double?,
        @Column(name = "amperage")
        val amperage: Double?,
        @Column(name = "speed")
        val speed: Double?,
        @Column(name = "status")
        val status: Int,
        @Column(name = "hw_ver")
        val hwVer: Int,
        @Column(name = "sw_ver")
        val swVer: Int
)