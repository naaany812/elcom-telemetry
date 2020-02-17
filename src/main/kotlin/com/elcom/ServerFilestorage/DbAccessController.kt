package com.elcom.ServerFilestorage

import com.elcom.ServerFilestorage.model.Device
import com.elcom.ServerFilestorage.model.Measure
import com.elcom.ServerFilestorage.model.Reply
import com.elcom.ServerFilestorage.repository.DeviceRepository
import com.elcom.ServerFilestorage.repository.MeasuresRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/api")
open class DbAccessController {

    @Autowired
    lateinit var measuresRepository: MeasuresRepository
    @Autowired
    lateinit var deviceRepository: DeviceRepository


    @GetMapping("/measures")
    fun getMeasures(@RequestParam count: Int): List<Measure> {
        //  measuresRepository.
        return measuresRepository.findAll()
    }

    @GetMapping("/devices")
    fun getDevices(@RequestParam count: Int): List<Device> {
        return deviceRepository.findAll()
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
        }
        catch(e:org.postgresql.util.PSQLException)
        {
            reply=Reply("${e.message}",1)
        }
        return reply
    }
}