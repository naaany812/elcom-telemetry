package com.elcom.ServerFilestorage

import com.elcom.ServerFilestorage.model.Device
import com.elcom.ServerFilestorage.model.Measure
import com.elcom.ServerFilestorage.model.Reply
import com.elcom.ServerFilestorage.repository.DeviceRepository
import com.elcom.ServerFilestorage.repository.MeasuresRepository
import com.elcom.ServerFilestorage.repository.SystemRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.*
import java.sql.Date

@RestController
@RequestMapping("/api")
open class DbAccessController {

    @Autowired
    lateinit var measuresRepository: MeasuresRepository
    @Autowired
    lateinit var deviceRepository: DeviceRepository
    @Autowired
    lateinit var systemRepository: SystemRepository

    @GetMapping("/measures")
    fun getMeasures(@RequestParam(required = false) startDate: Date?, @RequestParam(required = false) endDate: Date?, @RequestParam(required = false) systemId: Int?): List<Measure> {
        //  measuresRepository.
        if (startDate != null && endDate != null && systemId != null) {
            println("range formed")
            return measuresRepository.getRangeForSystem(startDate, endDate, systemId)
        } else
            return measuresRepository.findAll()
    }

    @GetMapping("/devices")
    fun getDevices(@RequestParam count: Int): List<Device> {
        return deviceRepository.findAll()
    }

    @GetMapping("/systems")
    fun getSystems(): List<com.elcom.ServerFilestorage.model.System> {
        return systemRepository.findAll()
    }

    @GetMapping("/adddevice")
    fun addOrUpdateDevice(@RequestParam id: Int,
                          @RequestParam swVer: Int,
                          @RequestParam hwVer: Int,
                          @RequestParam headId: Int,
                          @RequestParam configLink: String): Reply {
        var reply = Reply("OK")
        try {
            deviceRepository.save(Device(deviceHwId = id,
                    deviceHead = headId,
                    swVer = swVer,
                    hwVer = hwVer,
                    configLink = configLink))
        } catch (e: org.postgresql.util.PSQLException) {
            reply = Reply("${e.message}", 1)
        }
        return reply
    }

    @PostMapping(path = arrayOf("/addmeasure"), consumes = arrayOf("application/json"), produces = arrayOf("application/json"))
    fun addOrUpdateMeasure(@RequestBody measure: Measure): Reply {
        var reply = Reply("OK")
        try {
            measuresRepository.save(measure)
        } catch (e: org.postgresql.util.PSQLException) {
            reply = Reply("${e.message}", 1)
        }
        return reply
    }
}