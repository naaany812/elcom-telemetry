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
        val id: Int = -1,

        @Column(name = "car_number")
        val carNumber: Int = 0,
        @Column(name = "device_uid")
        val deviceHwId: String = "",

        @Column(name = "type")
        @Enumerated(EnumType.ORDINAL)
        val type: CarType,
        @Column(name = "system_id")
        val trainId: Int,
        @Column(name = "hw")
        val hwVer: Int = 0,
        @Column(name = "sw")
        val swVer: Int = 0,
        @Column(name = "config_link")
        val configLink: String = ""
)