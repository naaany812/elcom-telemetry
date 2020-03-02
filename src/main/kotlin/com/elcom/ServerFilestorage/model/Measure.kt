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
//
//        @ManyToOne(cascade = [CascadeType.ALL])
//        @JoinColumn(name = "device_hw_id", referencedColumnName = "device_hw_id")

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
        @Column(name = "wattage")
        val wattage: Double,
        @Column(name = "temperature")
        val temperature: Double,
        @Column(name = "status")
        val status: Int,
        @Column(name = "hw_ver")
        val hwVer: Int,
        @Column(name = "sw_ver")
        val swVer: Int
)