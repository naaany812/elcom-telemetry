package com.elcom.ServerFilestorage.model

import javax.persistence.*

@Entity
@Table(name = "systems")
data class System(
        @Id
        @GeneratedValue(strategy = GenerationType.AUTO)
        val id: Int = -1,

//        @ManyToOne(cascade = [CascadeType.ALL])
//        @JoinColumn(name = "head_device_id", referencedColumnName = "device_hw_id")
//        val headDevice: Device,

        @Column(name = "train_type")
        val trainType: String,

        @Column(name = "system_id")
        val systemId: Int,

        @Column(name = "status")
        val status: Int,

        @Column(name = "head_device_id")
        val headDeviceId: Int
)