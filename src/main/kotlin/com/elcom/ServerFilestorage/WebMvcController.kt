package com.elcom.ServerFilestorage

import com.example.uploadingfiles.storage.FileSystemStorageService
import com.example.uploadingfiles.storage.StorageFileNotFoundException
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.core.io.Resource
import org.springframework.http.HttpHeaders
import org.springframework.http.ResponseEntity
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.*
import org.springframework.web.multipart.MultipartFile
import org.springframework.web.servlet.config.annotation.EnableWebMvc
import org.springframework.web.servlet.mvc.method.annotation.MvcUriComponentsBuilder
import org.springframework.web.servlet.mvc.support.RedirectAttributes
import java.io.IOException
import java.nio.file.Path
import java.util.stream.Collectors


//import com.example.uploadingfiles.storage.StorageFileNotFoundException;
//import com.example.uploadingfiles.storage.StorageService;
@Controller
@EnableWebMvc
open class WebMvcController {
//    @Autowired
//    lateinit var storageService: FileSystemStorageService

    @RequestMapping("/")
    @Throws(IOException::class)
    open fun getHome(model: Model): String {
//        model.addAttribute("files", storageService.loadAll().map { path: Path ->
//            MvcUriComponentsBuilder.fromMethodName(WebMvcController::class.java,
//                    "serveFile", path.fileName.toString()).build().toString()
//        }.collect(Collectors.toList()))
       // var params = HashMap<String, Any?>()
        //  params.put("files",model.getAttribute("files"))
        //   var file form
        return "redirect:/login"
    }

    @RequestMapping("/login")
    @Throws(IOException::class)
    open fun getLogin(@RequestParam(value="error",required = false) error: String?,@RequestParam(value="logout",required = false) logout: String?): String {

        return "login"
    }

    @RequestMapping("/systems")
    @Throws(IOException::class)
    open fun getSystems(model: Model): String {

        return "systems"
    }
    @RequestMapping("/admin")
    @Throws(IOException::class)
    open fun getAdmin(model: Model): String {

        return "admin"
    }
    @RequestMapping("/measures")
    @Throws(IOException::class)
    open fun getMeasures(model: Model): String {
//        model.addAttribute("files", storageService.loadAll().map { path: Path ->
//            MvcUriComponentsBuilder.fromMethodName(WebMvcController::class.java,
//                    "serveFile", path.fileName.toString()).build().toString()
//        }
//                .collect(Collectors.toList()))
//        var params = HashMap<String, Any?>()
        //  params.put("files",model.getAttribute("files"))
        //   var file form
        return "measures"
    }

//    @GetMapping("/files/{filename:.+}")
//    @ResponseBody
//    fun serveFile(@PathVariable filename: String?): ResponseEntity<Resource?>? {
//        val file: Resource = storageService.loadAsResource(filename!!)
//        return ResponseEntity.ok().header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + file.filename.toString() + "\"").body<Resource?>(file)
//    }
//
//    @PostMapping("/")
//    fun handleFileUpload(@RequestParam("file") file: MultipartFile,
//                         redirectAttributes: RedirectAttributes): String? {
//        storageService.store(file)
//        redirectAttributes.addFlashAttribute("message",
//                "You successfully uploaded " + file.originalFilename + "!")
//        return "redirect:/"
//    }

    @ExceptionHandler(StorageFileNotFoundException::class)
    fun handleStorageFileNotFound(exc: StorageFileNotFoundException?): ResponseEntity<*>? {
        return ResponseEntity.notFound().build<Any>()
    }
}