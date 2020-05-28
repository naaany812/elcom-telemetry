package com.elcom.ServerFilestorage

import com.elcom.ServerFilestorage.storage.StorageProperties
import com.elcom.ServerFilestorage.storage.StorageService
import org.springframework.boot.CommandLineRunner
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.context.properties.EnableConfigurationProperties
import org.springframework.boot.runApplication
import org.springframework.context.annotation.Bean


@SpringBootApplication(scanBasePackages = ["com.elcom.ServerFilestorage.storage", "com.elcom.ServerFilestorage", "com.elcom.ServerFilestorage.utils"])
@EnableConfigurationProperties(StorageProperties::class)
class ServerFilestorageApplication

fun main(args: Array<String>) {
    runApplication<ServerFilestorageApplication>(*args)
}

@Bean
fun init(storageService: StorageService): CommandLineRunner? {
    return CommandLineRunner { args: Array<String?>? ->
        storageService.deleteAll()
        storageService.init()
    }
}