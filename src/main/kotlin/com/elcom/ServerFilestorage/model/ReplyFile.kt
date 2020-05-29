package com.elcom.ServerFilestorage.model
data class ReplyFile(
        var crc: String,
        var data: String="",
        var status: Int = 0
)