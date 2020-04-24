package com.elcom.ServerFilestorage

import com.elcom.ServerFilestorage.model.*
import com.elcom.ServerFilestorage.repository.*
import com.elcom.ServerFilestorage.utils.CRC
import com.elcom.ServerFilestorage.utils.HexParser
import com.example.uploadingfiles.storage.FileSystemStorageService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.core.io.Resource
import org.springframework.data.repository.cdi.CdiRepositoryContext
import org.springframework.http.HttpHeaders
import org.springframework.http.HttpStatus
import org.springframework.http.MediaType
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import org.springframework.web.multipart.MultipartFile
import org.springframework.web.servlet.support.ServletUriComponentsBuilder
import java.io.IOException
import java.lang.System
import java.nio.file.Files
import java.sql.Date
import java.sql.Time
import java.sql.Timestamp
import javax.servlet.http.HttpServletRequest
import kotlin.experimental.and
import kotlin.experimental.xor


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
    @Autowired
    lateinit var storageService: FileSystemStorageService
    @Autowired
    lateinit var filesService: FileDataRepository

    @GetMapping("/measures")
    fun getMeasures(@RequestParam(required = false) startDate: Date?, @RequestParam(required = false) endDate: Date?, @RequestParam(required = false) systemId: Int?): List<Measure> {
        //  measuresRepository.
        if (startDate != null && endDate != null && systemId != null) {
            println("range formed")
            return measuresRepository.getRangeForSystem(startDate, endDate, systemId)
        } else
            return measuresRepository.findAll()
    }

    @GetMapping("/files")
    fun getFilesList(): List<FileData> {
        return filesService.findAll()
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

    //    @GetMapping("/radio")
//    fun getRadio(@RequestParam(required = false) startDate: String?, @RequestParam(required = false) endDate: String?, @RequestParam(required = false) deviceUid: String?): List<DataRadio> {
//        //  measuresRepository.
//        if (startDate != null && endDate != null && deviceUid != null) {
//            println("$startDate - $endDate")
//            return energyRepository.getRange(Timestamp.valueOf("$startDate 00:00:00"), Timestamp.valueOf("$endDate 00:00:00"), deviceUid)
//        } else
//            return energyRepository.findAll()
//    }
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

    @PostMapping(path = arrayOf("/add/measures"), consumes = arrayOf("application/json"), produces = arrayOf("application/json"))
    fun addOrUpdateMeasure(@RequestBody measure: MeasureHex): Reply {
        var reply = Reply(System.currentTimeMillis(), HttpStatus.OK.value())
        // println(measure)
        try {
            println(measure)
            for (data in measure.d) {
                var result = HexParser.parseMeasure(measure.h, data)
                var dev = deviceRepository.getFirstDeviceByUid(result.UID)
                println(result)
                when (result) {
                    is DataClimate -> climateRepository.save(result)
                    is DataEnergy -> energyRepository.save(result)
                    is DataRadio -> {
                    }
                    else -> reply = Reply(dev.swVer!!.toLong(), HttpStatus.NOT_ACCEPTABLE.value())
                }
            }
        } catch (e: Exception) {
            reply = Reply(0, HttpStatus.BAD_REQUEST.value())
            e.printStackTrace()
        }
        return reply
    }

    @PostMapping(path = arrayOf("/add/measuresold"), consumes = arrayOf("application/json"), produces = arrayOf("application/json"))
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

    @GetMapping("/downloadFile/{filename:.+}")
    @ResponseBody
    fun downloadFile(@PathVariable filename: String?, request: HttpServletRequest): ResponseEntity<Resource?>? {
        val file: Resource = storageService.loadAsResource(filename!!)

        var contentType: String? = null
        try {
            contentType = request.servletContext.getMimeType(file.file.absolutePath)
        } catch (ex: IOException) {
            println("Could not determine file type.")
        }

        if (contentType == null) {
            contentType = "application/octet-stream";
        }
        return ResponseEntity.ok()
                .contentType(MediaType.parseMediaType(contentType))
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + file.filename + "\"")
                .body(file);
        //  return ResponseEntity.ok().header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + file.filename.toString() + "\"").body<Resource?>(file)
    }

    @GetMapping("/getBlock", produces = [MediaType.APPLICATION_OCTET_STREAM_VALUE])
    @ResponseBody
    fun getFileBlock2(@RequestParam("uid") uid: String, @RequestParam("from") from: Long, @RequestParam("to") to: Long): ByteArray {

        var dev = deviceRepository.getFirstDeviceByUid(uid)

        var fileData = filesService.getOne(dev.swId!!)

        val file: Resource = storageService.loadAsResource(fileData.name)
        val fileEncoded = Files.readAllBytes(file.file.toPath())
        val block = fileEncoded.copyOfRange(from.toInt(), to.toInt())

        // val resultFileBlock =
        var contentType: String = "application/octet-stream"

        return block
    }

    @PostMapping("/getFile", produces = arrayOf("application/json"))
    @ResponseBody
    fun getFileBlock(@RequestBody measure: MeasureHex): ReplyFile {

        //  print(measure)
        var request = HexParser.parseMeasure(measure.h, measure.d[0])
        //print(request)
        var reply: ReplyFile
        when (request) {
            is DataFileRequest -> {
                var dev = deviceRepository.getFirstDeviceByUid(request.UID)
                var fileData = filesService.getOne(dev.swId!!)

                val file: Resource = storageService.loadAsResource(fileData.name)
                val fileEncoded = Files.readAllBytes(file.file.toPath())
                val block = fileEncoded.copyOfRange(request.from, request.to)
                println("${request.from} - ${request.to}")
                reply = ReplyFile(0, String(block), HttpStatus.OK.value())
            }
            else -> {
                println(request)
                reply = ReplyFile(0, "$request", HttpStatus.NOT_ACCEPTABLE.value())
            }
        }

        return reply
    }

    fun splitFile() {}

    @GetMapping("/filesize")
    fun getFileSizeInBytes(@RequestParam("uid") uid: String): Long {
        var dev = deviceRepository.getFirstDeviceByUid(uid)

        if (dev.swId == null)
            return 0

        var fileData = filesService.getOne(dev.swId!!)
        // var file = storageService.loadAs(filename=fileData.name)
        //  file.
        return fileData.size
    }

//    @GetMapping("/getfirst")
//    @ResponseBody
//    fun getfirstDevice(@RequestParam("uid") uid: String) : Device
//    {
//            return deviceRepository.getFirstDeviceByUid(uid)
//    }


    @GetMapping("/setFile")
    @ResponseBody
    fun setFile(@RequestParam("uid") uid: String, @RequestParam("fileId") id: Int): Reply {

        println("$uid : $id")
        var dev = deviceRepository.getFirstDeviceByUid(uid)
        dev.swId = id
        var file = filesService.getOne(id)
        dev.swVer = file.version
        dev.update = true
        deviceRepository.save(dev)

        return Reply(System.currentTimeMillis(), HttpStatus.OK.value())
    }

    @GetMapping("/endUpdate")
    fun endUpdate(@RequestParam("uid") uid: String): Reply {
        var dev = deviceRepository.getFirstDeviceByUid(uid)
        dev.update = false
        deviceRepository.save(dev)
        return Reply(System.currentTimeMillis(), HttpStatus.OK.value())
    }

    /*TODO */
    fun updateSwVersion() {}

    @PostMapping("/uploadFile")
    @ResponseBody
    fun uploadFile(@RequestParam("file") file: MultipartFile, @RequestParam("version") version: Int): Reply {
        storageService.store(file)
        val fileDownloadUri = ServletUriComponentsBuilder.fromCurrentContextPath()
                .path("/downloadFile/")
                .path(file.name)
                .toUriString()
        val fileData: FileData = FileData(name = file.originalFilename!!, version = version, size = file.size)
        filesService.save(fileData)
//        redirectAttributes.addFlashAttribute("message",
//                "You successfully uploaded " + file.originalFilename + "!")
        return Reply(System.currentTimeMillis(), HttpStatus.OK.value())
    }

}