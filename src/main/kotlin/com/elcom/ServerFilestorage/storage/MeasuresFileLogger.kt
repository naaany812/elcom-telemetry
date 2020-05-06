package com.elcom.ServerFilestorage.storage

import java.io.File
import java.sql.Date
import java.sql.Timestamp
import java.text.SimpleDateFormat
import java.util.*


class MeasuresFileLogger() {
    companion object {
        fun saveMessage(message: String,timestamp: Timestamp, ext: String) {
            var cal = Calendar.getInstance()
            // var filename = cal.time
            val format = SimpleDateFormat("dd-MM-yyyy")
            val filename = format.format(timestamp)
            val path = File("./logs/")
            path.mkdirs()
            var file = File(path,"$filename.$ext")
            if (!file.exists()) {
                file.createNewFile()
            }
            if (file.canWrite()) {
                file.appendText("$message\n")
            }
        }
    }
}