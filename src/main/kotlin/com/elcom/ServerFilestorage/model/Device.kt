package com.elcom.ServerFilestorage.model

import javax.persistence.*

@Entity
@Table(name = "devices")
data class Device
(
        @Id
        @GeneratedValue(strategy = GenerationType.AUTO)
        val id: Int = -1,

        @Column(name = "device_hw_id")
        val deviceHwId: Int = 0,

        @Column(name = "device_head_id")
        val deviceHead: Int = 0,

        @ManyToOne(cascade = [CascadeType.ALL])
        @JoinColumn(name = "device_hw_head_id", referencedColumnName = "device_hw_id")
        val deviceHeadInstance: Device? = null,

        @Column(name = "hw_ver")
        val hwVer: Int = 0,
        @Column(name = "sw_ver")
        val swVer: Int = 0,
        @Column(name = "config_link")
        val configLink: String = ""
)