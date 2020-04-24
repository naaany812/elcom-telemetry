package com.elcom.ServerFilestorage.model

import javax.persistence.Entity

data class ReplyFile(
        var crc: Long,
        var data: String="",
        var status: Int = 0
)