package com.elcom.ServerFilestorage.storage

import java.io.File
import java.sql.Date
import java.sql.Timestamp
import java.text.SimpleDateFormat
import java.util.*


class MeasuresFileLogger() {
    companion object {
        val CODE_BKTE = "10"
        val CODE_BKT = "11"
        val CODE_BSG = "12"
        fun saveMessage(message: String, timestamp: Timestamp, uid: String, ext: String, code: String) {
            val format = SimpleDateFormat("dd-MM-yyyy")
            val filename = format.format(timestamp)
            val path = File("./logs/${uid}/")
            val type = when (code) {
                CODE_BKTE -> "BKTE"
                CODE_BKT -> "BKT"
                CODE_BSG -> "BSG"
                else -> "UNKNOWN"
            }
            path.mkdirs()
            var file = File(path, "${filename}_${type}_${uid}.$ext")
            if (!file.exists()) {
                file.createNewFile()
            }
            if (file.canWrite()) {
                file.appendText("$message\n")
            }
        }
    }
}