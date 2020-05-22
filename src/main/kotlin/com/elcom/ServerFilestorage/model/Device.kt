package com.elcom.ServerFilestorage.model

import javax.persistence.*

enum class CarType {
        PG,MP,PP
}

@Entity
@Table(name = "devices")
data class Device
(
        @Id
        @GeneratedValue(strategy = GenerationType.AUTO)
        var id: Int = -1,

        @Column(name = "car_number")
        var carNumber: Int = 0,
        @Column(name = "device_uid")
        var deviceHwId: String = "",

        @Column(name = "type")
        @Enumerated(EnumType.ORDINAL)
        var type: CarType,
        @Column(name = "system_id")
        var trainId: Int,
        @Column(name = "hw")
        var hwVer: Int = 0,
        @Column(name = "sw")
        var swVer: Int? = 0,
        @Column(name = "config_link")
        var configLink: Int =0,
        @Column(name = "sw_link")
        var swId: Int? = 0,
        @Column(name = "updates")
        var update: Boolean = false,
        @Column(name = "name")
        var name: String = "UNKNOWN"
)