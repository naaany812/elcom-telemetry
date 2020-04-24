package com.elcom.ServerFilestorage.model

import javax.persistence.Entity

data class Reply(
        val version: Long,
        val status: Int = 0
)