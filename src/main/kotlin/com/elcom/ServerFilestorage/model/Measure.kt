package com.elcom.ServerFilestorage.model

import javax.persistence.*

@Entity
@Table(name = "measures")
data class Measure
(
        @Id
        @GeneratedValue(strategy = GenerationType.AUTO)
        val id: Int = -1,

        @ManyToOne(cascade = [CascadeType.ALL])
        @JoinColumn(name = "device_hw_id", referencedColumnName = "device_hw_id")
        val device: Device,

        @Column(name = "hw_ver")
        val hwVer: Int,
        @Column(name = "sw_ver")
        val swVer: Int,
        @Column(name = "config_link")
        val configLink: String
)