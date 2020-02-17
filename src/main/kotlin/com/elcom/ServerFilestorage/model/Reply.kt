package com.elcom.ServerFilestorage.model

import javax.persistence.Entity

data class Reply(
        val message: String,
        val status: Int = 0
)