package com.elcom.ServerFilestorage.model

import javax.persistence.*

@Entity
@Table(name = "software")
data class FileData(
        @Id
        @GeneratedValue(strategy = GenerationType.AUTO)
        var id: Int =-1,
        @Column(name = "filename")
        var name: String = "unknown",
        @Column(name = "version")
        var version: Int = 0,
        @Column(name = "path")
        var path: String = "unknown",
        @Column(name = "actual")
        var actual: Boolean = true,
        @Column(name = "link")
        var link: String = "empty",
        @Column(name = "size")
        var size: Long = 0
)