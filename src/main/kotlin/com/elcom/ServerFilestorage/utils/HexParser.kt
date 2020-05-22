package com.elcom.ServerFilestorage.utils

import com.elcom.ServerFilestorage.model.*
import java.lang.System
import java.sql.Timestamp

class HexParser {
    companion object {

        val DATA_CLIMATE = "40"
        val DATA_ENERGY = "50"
        val DATA_SERVICE = "21"
        val DATA_RADIO = "22"
        val DATA_FILE = "23"
        val DATA_GEO = "60"


        fun parseMeasure(header: String, data: String): HeaderMeasure {
            //  var result = Measure()
            //  println("parsing measure")
            val headerStringBytes = header.chunked(2)
            val dataStringBytes = data.chunked(2)

            //   println(dataStringBytes[3])
            val result = when (dataStringBytes[3]) {
                DATA_CLIMATE -> parseClimate(dataStringBytes)
                DATA_ENERGY -> parseEnergy(dataStringBytes)
                DATA_SERVICE -> parseService(dataStringBytes)
                DATA_RADIO -> parseRadio(dataStringBytes)
                DATA_GEO -> parseGeo(data)
                DATA_FILE -> parseFile(dataStringBytes)
                else -> HeaderMeasure()
            }
            var res = parseHeader(result, headerStringBytes, dataStringBytes)
            println(res)
            return res
        }

        private fun parseHeader(header: HeaderMeasure, bytes: List<String>, dataStringBytes: List<String>): HeaderMeasure {
            //   println("parsing header")
            header.orderNum = dataStringBytes.subList(0, 1).joinToString("").toInt(16)
            header.UID = bytes.subList(1, 13).joinToString("")
            header.idTrain = (bytes[13] + bytes[14]).toInt(16)
            header.idWagon = bytes[15].toInt(16)
            header.receiverCode = (bytes[16] + bytes[17]).toInt(16)
            header.deviceId = dataStringBytes[2]
            header.commandType = dataStringBytes[3].toInt(16)
            header.timestamp = Timestamp(dataStringBytes.subList(4, 8).joinToString("").toLong(16) * 1000)
            header.timestampReceived = Timestamp(System.currentTimeMillis())
            //  println(header)
            return header
        }

        private fun parseClimate(dataStringBytes: List<String>): DataClimate {
            return DataClimate(
                    channel1 = dataStringBytes[8].toInt(16),
                    channel2 = dataStringBytes[9].toInt(16),
                    channel3 = dataStringBytes[10].toInt(16),
                    channel4 = dataStringBytes[11].toInt(16)
            )
        }

        private fun parseEnergy(dataStringBytes: List<String>): DataEnergy {
            return DataEnergy(
                    amperage = dataStringBytes.subList(8, 10).joinToString("").toInt(16),
                    voltage = dataStringBytes.subList(10, 12).joinToString("").toInt(16),
                    energyActive = dataStringBytes.subList(12, 16).joinToString("").toInt(16),
                    energyPassive = dataStringBytes.subList(16, 20).joinToString("").toInt(16)
            )
        }

        private fun parseService(dataStringBytes: List<String>): DataService {
            return DataService(
                    swVer = dataStringBytes.subList(6, 8).joinToString("").toInt(16),
                    hwVer = dataStringBytes.subList(8, 10).joinToString("").toInt(16),
                    phone = dataStringBytes.subList(10, 14).joinToString("").toInt(16),
                    balance = dataStringBytes.subList(14, 16).joinToString("").toInt(16),
                    enableTime = dataStringBytes.subList(16, 20).joinToString("").toInt(16),
                    disableTime = dataStringBytes.subList(20, 24).joinToString("").toInt(16))
        }

        private fun parseRadio(dataStringBytes: List<String>): DataRadio {
            return DataRadio(
                    rssi = dataStringBytes[8].toInt(16),
                    rssiReverse = dataStringBytes[9].toInt(16),
                    receivedCount = dataStringBytes.subList(10, 14).joinToString("").toLong(16),
                    totalCount = dataStringBytes.subList(14, 18).joinToString("").toLong(16))
        }

        private fun parseGeo(dataStringBytes: String): DataGeo {

            var data = dataStringBytes.split(' ')
            var dataGeoSplitted = data[1].split(',')
            return DataGeo(
                    latitude = "${dataGeoSplitted[0]}${dataGeoSplitted[1]}",
                    longitude = "${dataGeoSplitted[2]}${dataGeoSplitted[3]}",
                    alt = dataGeoSplitted[4].toDouble(),
                    speed = dataGeoSplitted[5].toDouble(),
                    course = dataGeoSplitted[6].toDouble()

            )
        }

        private fun parseFile(dataStringBytes: List<String>): DataFileRequest {
            println("file parsed")
            return DataFileRequest(
                    from = dataStringBytes.subList(8, 12).joinToString("").toInt(16),
                    to = dataStringBytes.subList(12, 16).joinToString("").toInt(16)
            )
        }
    }
}