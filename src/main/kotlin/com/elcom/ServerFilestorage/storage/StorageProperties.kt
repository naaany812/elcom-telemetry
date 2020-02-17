package com.elcom.ServerFilestorage.storage

import com.example.uploadingfiles.storage.FileSystemStorageService
import org.springframework.boot.context.properties.ConfigurationProperties
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.context.annotation.Description
import org.springframework.http.converter.HttpMessageConverter
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter
import org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport


@ConfigurationProperties("storage")
open class StorageProperties {
    /**
     * Folder location for storing files
     */
    var location = "upload-dir"

    @Bean
    fun fileSystemStorageService(): FileSystemStorageService {
        return FileSystemStorageService(this)
    }
    /*@Configuration
    class CustomWebMvcConfiguration : WebMvcConfigurationSupport() {
        override fun extendMessageConverters(converters: List<HttpMessageConverter<*>?>) {
            for (converter in converters) {
                if (converter is MappingJackson2HttpMessageConverter) {
                    converter.setPrettyPrint(true)
                }
            }
        }
    }*/
}