package com.elcom.ServerFilestorage

import com.elcom.ServerFilestorage.model.*
import com.elcom.ServerFilestorage.repository.*
import com.elcom.ServerFilestorage.utils.HexParser
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.dao.DataIntegrityViolationException
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.*
import java.lang.System
import java.sql.Date
import java.sql.Time
import java.sql.Timestamp


@RestController
@RequestMapping("/api")
open class ApiController {
    @Autowired
    lateinit var measuresRepository: MeasuresRepository
    @Autowired
    lateinit var deviceRepository: DeviceRepository
    @Autowired
    lateinit var systemRepository: SystemRepository
    @Autowired
    lateinit var energyRepository: DataEnergyRepository
    @Autowired
    lateinit var climateRepository: DataClimateRepository

    @GetMapping("/measures")
    fun getMeasures(@RequestParam(required = false) startDate: Date?, @RequestParam(required = false) endDate: Date?, @RequestParam(required = false) systemId: Int?): List<Measure> {
        //  measuresRepository.
        if (startDate != null && endDate != null && systemId != null) {
            println("range formed")
            return measuresRepository.getRangeForSystem(startDate, endDate, systemId)
        } else
            return measuresRepository.findAll()
    }

    @GetMapping("/measuresnew")
    fun getMeasuresNew(@RequestParam(required = false) startDate: Date?, @RequestParam(required = false) endDate: Date?, @RequestParam(required = false) systemId: Int?): List<Measure> {
        //  measuresRepository.
        if (startDate != null && endDate != null && systemId != null) {
            println("range formed")
            return measuresRepository.getRangeForSystem(startDate, endDate, systemId)
        } else
            return measuresRepository.findAll()
    }

    @GetMapping("/climate")
    fun getClimate(@RequestParam(required = false) startDate: String?, @RequestParam(required = false) endDate: String?, @RequestParam(required = false) deviceUid: String?): List<DataClimate> {
        //  measuresRepository.
        if (startDate != null && endDate != null && deviceUid != null) {
            println("$startDate - $endDate")
            return climateRepository.getRange(Timestamp.valueOf("$startDate 00:00:00"), Timestamp.valueOf("$endDate 00:00:00"), deviceUid)
        } else
            return climateRepository.findAll()
    }

    @GetMapping("/energy")
    fun getEnergy(@RequestParam(required = false) startDate: String?, @RequestParam(required = false) endDate: String?, @RequestParam(required = false) deviceUid: String?): List<DataEnergy> {
        //  measuresRepository.
        if (startDate != null && endDate != null && deviceUid != null) {
            println("$startDate - $endDate")
            return energyRepository.getRange(Timestamp.valueOf("$startDate 00:00:00"), Timestamp.valueOf("$endDate 00:00:00"), deviceUid)
        } else
            return energyRepository.findAll()
    }

    @GetMapping("/time")
    fun getTimestamp(): Reply {
        return Reply(System.currentTimeMillis(), HttpStatus.OK.value())
    }

    @GetMapping("/devices")
    fun getDevices(@RequestParam(required = false) trainId: Int?, @RequestParam(required = false) onlyHead: Boolean?): List<Device> {
        if (trainId != null) {
            if (onlyHead != null)
                return deviceRepository.getHeadDevicesFromTrain(trainId)
            else
                return deviceRepository.getDevicesFromTrain(trainId)
        } else
            return deviceRepository.findAll()
    }

    @GetMapping("/systems")
    fun getSystems(): List<com.elcom.ServerFilestorage.model.System> {
        return systemRepository.findAll()
    }

    @PostMapping(path = arrayOf("/add/devices"), consumes = arrayOf("application/json"), produces = arrayOf("application/json"))
    fun addOrUpdateDevice(@RequestBody device: Device): Reply {
        var reply = Reply(System.currentTimeMillis(), HttpStatus.OK.value())
        println("Device added: $device")
        try {
            deviceRepository.save(device)
        } catch (e: Exception) {
            reply = Reply(System.currentTimeMillis(), HttpStatus.BAD_REQUEST.value())
        }
        return reply
    }

    @PostMapping(path = arrayOf("/add/measuresnew"), consumes = arrayOf("application/json"), produces = arrayOf("application/json"))
    fun addOrUpdateMeasure(@RequestBody measure: MeasureHex): Reply {
        var reply = Reply(System.currentTimeMillis(), HttpStatus.OK.value())
        // println(measure)
        try {
            var result = HexParser.parseMeasure(measure)
            println(result)


            when (result) {
                is DataClimate -> climateRepository.save(result)
                is DataEnergy -> energyRepository.save(result)
                else -> reply = Reply(System.currentTimeMillis(), HttpStatus.NOT_ACCEPTABLE.value())
            }
        } catch (e: Exception) {
            reply = Reply(System.currentTimeMillis(), HttpStatus.BAD_REQUEST.value())
            e.printStackTrace()
        }
        return reply
    }

    @PostMapping(path = arrayOf("/add/measures"), consumes = arrayOf("application/json"), produces = arrayOf("application/json"))
    fun addOrUpdateMeasureOld(@RequestBody measure: Measure): Reply {
        var reply = Reply(System.currentTimeMillis(), HttpStatus.OK.value())
        println(measure)
        try {
            val day = measure.dateGSM.chunked(2).map { Integer.parseInt(it) }
            val time = measure.timeGSM.chunked(2).map { Integer.parseInt(it) }
            measure.date = Date((100 + day[2]), day[1] - 1, day[0])
            measure.time = Time(time[2], time[1], time[0])
            measuresRepository.save(measure)
        } catch (e: Exception) {
            reply = Reply(System.currentTimeMillis(), HttpStatus.BAD_REQUEST.value())
        }
        return reply
    }

    @PostMapping(path = arrayOf("/add/systems"), consumes = arrayOf("application/json"), produces = arrayOf("application/json"))
    fun addOrUpdateSystem(@RequestBody system: com.elcom.ServerFilestorage.model.System): Reply {
        var reply = Reply(System.currentTimeMillis(), HttpStatus.OK.value())
        println("Train added: $system")
        try {
            systemRepository.save(system)
        } catch (e: Exception) {
            reply = Reply(System.currentTimeMillis(), HttpStatus.BAD_REQUEST.value())
        }
        return reply
    }
}