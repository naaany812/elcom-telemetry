package com.elcom.ServerFilestorage.utils

import com.elcom.ServerFilestorage.model.*
import java.sql.Timestamp

class HexParser {
    companion object {
        val CODE_BKTE = "10"
        val CODE_BKT = "11"
        val CODE_BSG = "12"

        val DATA_CLIMATE = "40"
        val DATA_ENERGY = "50"
        val DATA_SERVICE = "21"
        val DATA_RADIO = "22"
        val DATA_GEO = "60"


        fun parseMeasure(header: String , data: String) : HeaderMeasure {
            //  var result = Measure()
          //  println("parsing measure")
            val headerStringBytes = header.chunked(2)
            val dataStringBytes = data.chunked(2)
            val result = when (dataStringBytes[3]) {
                DATA_CLIMATE -> parseClimate(dataStringBytes)
                DATA_ENERGY -> parseEnergy(dataStringBytes)
                DATA_SERVICE -> parseService(dataStringBytes)
                DATA_RADIO -> parseRadio(dataStringBytes)
                DATA_GEO -> parseGeo(dataStringBytes)
                else -> HeaderMeasure()
            }
            return parseHeader(result, headerStringBytes, dataStringBytes)
        }

        private fun parseHeader(header: HeaderMeasure, bytes: List<String>, dataStringBytes: List<String>): HeaderMeasure {
         //   println("parsing header")
            header.orderNum = dataStringBytes.subList(0, 1).joinToString("").toInt(16)
            header.UID = bytes.subList(1, 13).joinToString("")
            header.idTrain = (bytes[13] + bytes[14]).toInt(16)
            header.idWagon = bytes[15].toInt(16)
            header.receiverCode = (bytes[16] + bytes[17]).toInt(16)
            header.deviceId = dataStringBytes[2].toInt(16)
            header.commandType = dataStringBytes[3].toInt(16)
            header.timestamp = Timestamp(dataStringBytes.subList(4, 8).joinToString("").toLong(16)*1000)
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

        private fun parseGeo(dataStringBytes: List<String>): DataGeo {
            return DataGeo(
                    latitude = dataStringBytes.subList(8, 12).joinToString("").toInt(16),
                    longitude = dataStringBytes.subList(12, 16).joinToString("").toInt(16),
                    speed = dataStringBytes.subList(16, 18).joinToString("").toInt(16),
                    angle = dataStringBytes.subList(18, 20).joinToString("").toInt(16),
                    UTC = dataStringBytes.subList(20, 24).joinToString("").toInt(16),
                    flag = dataStringBytes[24].toInt(16),
                    satCount = dataStringBytes[25].toInt(16)

            )
        }
    }
}