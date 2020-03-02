package com.elcom.ServerFilestorage.model

import javax.persistence.Entity

data class Reply(
        val timestamp: Long,
        val status: Int = 0
)