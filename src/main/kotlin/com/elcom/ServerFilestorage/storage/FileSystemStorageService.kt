package com.example.uploadingfiles.storage

import com.elcom.ServerFilestorage.storage.StorageProperties
import com.elcom.ServerFilestorage.storage.StorageService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.beans.factory.annotation.Qualifier
import org.springframework.context.annotation.Bean
import org.springframework.core.io.Resource
import org.springframework.core.io.UrlResource
import org.springframework.stereotype.Component
import org.springframework.stereotype.Service
import org.springframework.util.FileSystemUtils
import org.springframework.util.StringUtils
import org.springframework.web.multipart.MultipartFile
import java.io.File
import java.io.IOException
import java.net.MalformedURLException
import java.nio.file.Files
import java.nio.file.Path
import java.nio.file.Paths
import java.nio.file.StandardCopyOption
import java.util.stream.Stream

@Service
open class FileSystemStorageService constructor( @Autowired properties: StorageProperties) : StorageService {
    private val rootLocation: Path
    override fun store(file: MultipartFile) {
        val filename = StringUtils.cleanPath(file.originalFilename!!)
        try {
            if (file.isEmpty) {
                throw StorageException("Failed to store empty file $filename")
            }
            if (filename.contains("..")) { // This is a security check
                throw StorageException("Cannot store file with relative path outside current directory "
                        + filename)
            }
            file.inputStream.use { inputStream ->
                Files.copy(inputStream, rootLocation.resolve(filename),
                        StandardCopyOption.REPLACE_EXISTING)
            }
        } catch (e: IOException) {
            throw StorageException("Failed to store file $filename", e)
        }
    }

    override fun loadAll(): Stream<Path> {
        return try {
            Files.walk(rootLocation, 1)
                    .filter { path: Path -> path != rootLocation }
                    .map { path: Path? -> rootLocation.relativize(path) }
        } catch (e: IOException) {
            throw StorageException("Failed to read stored files", e)
        }
    }

    override fun load(filename: String): Path {
        return rootLocation.resolve(filename)
    }

    override fun loadAsResource(filename: String): Resource {
        return try {
            val file = load(filename)
            val resource: Resource = UrlResource(file.toUri())
            if (resource.exists() || resource.isReadable) {
                resource
            } else {
                throw StorageFileNotFoundException(
                        "Could not read file: $filename")
            }
        } catch (e: MalformedURLException) {
            throw StorageFileNotFoundException("Could not read file: $filename", e)
        }
    }

    override fun deleteAll() {
        FileSystemUtils.deleteRecursively(rootLocation.toFile())
    }

    override fun init() {
        try {
            Files.createDirectories(rootLocation)
        } catch (e: IOException) {
            throw StorageException("Could not initialize storage", e)
        }
    }

    init {
        var file = File("./${properties.location}/")
        file.mkdirs()
     //   createTempDir(properties.location)
        rootLocation = Paths.get(properties.location)
    }
}