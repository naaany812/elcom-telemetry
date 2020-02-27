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
        @Column(name = "device_hw_id")
        val deviceHwId: Int = 0,

        @Column(name = "type")
        @Enumerated(EnumType.ORDINAL)
        val type: CarType,
        @Column(name = "device_hw_head_id")
        val deviceHead: Int = 0,
        @Column(name = "name")
        val name: String = "",
        @Column(name = "train_id")
        val trainId: Int,
        @Column(name = "hw_ver")
        val hwVer: Int = 0,
        @Column(name = "sw_ver")
        val swVer: Int = 0,
        @Column(name = "config_link")
        val configLink: String = ""
)